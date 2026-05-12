import 'package:art_of_pilates/app/core/util/app_colors.dart';
import 'package:art_of_pilates/app/features/payment/presentation/view_model/payment_events.dart';
import 'package:art_of_pilates/app/features/payment/presentation/view_model/payment_states.dart';
import 'package:art_of_pilates/app/features/payment/presentation/view_model/payment_view_model.dart';
import 'package:art_of_pilates/app/widgets/app_exception_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:webview_flutter/webview_flutter.dart';

class TapPaymentScreen extends StatefulWidget {
  final String paymentUrl;
  final String chargeId;
  final void Function(bool success) onPaymentResult;
  final PaymentViewModel paymentViewModel;

  const TapPaymentScreen({
    super.key,
    required this.paymentUrl,
    required this.chargeId,
    required this.onPaymentResult,
    required this.paymentViewModel,
  });

  @override
  State<TapPaymentScreen> createState() => _TapPaymentScreenState();
}

class _TapPaymentScreenState extends State<TapPaymentScreen> {
  late final WebViewController _webViewController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initWebView();
  }

  void _initWebView() {
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (_) => setState(() => _isLoading = true),
          onPageFinished: (_) => setState(() => _isLoading = false),
          onNavigationRequest: (request) {
            if (request.url.contains('/payments/redirect')) {
              _handleRedirect(request.url);
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.paymentUrl));
  }

  void _handleRedirect(String url) {
    final uri = Uri.parse(url);
    final tapId = uri.queryParameters['tap_id'] ?? widget.chargeId;
    widget.paymentViewModel.onEvent(VerifyChargeEvent(chargeId: tapId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.paymentViewModel,
      child: BlocListener<PaymentViewModel, PaymentStates>(
        listenWhen: (prev, curr) =>
            prev.verifyChargeState != curr.verifyChargeState ||
            prev.appException != curr.appException,
        listener: (context, state) {
          if (state.appException != null &&
              state.verifyChargeState?.isLoading == false) {
            AppExceptionDialog.show(context, state.appException!).then((_) {
              if (context.mounted) {
                Navigator.pop(context);
                widget.onPaymentResult(false);
              }
            });
            return;
          }
          if (state.verifyChargeState?.isLoading == false &&
              state.verifyChargeState?.data != null) {
            final success = state.verifyChargeState!.data!.success ?? false;
            Navigator.pop(context);
            widget.onPaymentResult(success);
          }
          if (state.verifyChargeState?.errorMessage != null) {
            Navigator.pop(context);
            widget.onPaymentResult(false);
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.primary,
            centerTitle: true,
            title: const Text(
              'Secure Payment',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: IconButton(
              onPressed: () {
                widget.onPaymentResult(false);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.close, color: Colors.white),
            ),
          ),
          body: Stack(
            children: [
              WebViewWidget(controller: _webViewController),
              if (_isLoading)
                Container(
                  color: AppColors.backgroundColor,
                  child: const Center(child: CircularProgressIndicator()),
                ),
              BlocBuilder<PaymentViewModel, PaymentStates>(
                buildWhen: (prev, curr) =>
                    prev.verifyChargeState != curr.verifyChargeState,
                builder: (context, state) {
                  if (state.verifyChargeState?.isLoading ?? false) {
                    return Container(
                      color: Colors.black.withOpacity(0.5),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                            SizedBox(height: 12.h),
                            const Text(
                              'Verifying payment...',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
