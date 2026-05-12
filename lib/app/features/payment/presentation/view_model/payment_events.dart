sealed class PaymentEvents {}

class CreateChargeEvent extends PaymentEvents {
  final String sessionId;

  CreateChargeEvent({required this.sessionId});
}

class CreatePlanChargeEvent extends PaymentEvents {
  final int planId;

  CreatePlanChargeEvent({required this.planId});
}  

class VerifyChargeEvent extends PaymentEvents {
  final String chargeId;
  VerifyChargeEvent({required this.chargeId});
}