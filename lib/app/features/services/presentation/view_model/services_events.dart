sealed class ServicesEvents {}

class ServicesEvent extends ServicesEvents {}

class OneServiceEvent extends ServicesEvents {
  final String serviceId;
  OneServiceEvent({required this.serviceId});
}