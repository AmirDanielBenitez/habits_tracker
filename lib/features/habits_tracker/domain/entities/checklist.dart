import 'package:equatable/equatable.dart';

class CheckListEntity extends Equatable {
  final String name;
  final bool done;

  const CheckListEntity({
    required this.name,
    this.done = false,
  });

  @override
  List<Object?> get props {
    return [
      name,
      done,
    ];
  }
}
