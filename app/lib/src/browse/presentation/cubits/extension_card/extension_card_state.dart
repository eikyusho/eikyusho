part of 'extension_card_cubit.dart';

sealed class ExtensionCardState extends Equatable {
  const ExtensionCardState(this.progress, this.state);

  final double progress;
  final ProgressButtonState state;

  @override
  List<Object> get props => [progress, state];
}

final class ExtensionCardInitial extends ExtensionCardState {
  const ExtensionCardInitial() : super(0, ProgressButtonState.idle);
}

final class ExtensionCardDownloading extends ExtensionCardState {
  const ExtensionCardDownloading(double progress)
      : super(progress, ProgressButtonState.inProgress);
}

final class ExtensionCardDownloaded extends ExtensionCardState {
  const ExtensionCardDownloaded({required this.isUpdate})
      : super(1, ProgressButtonState.finished);

  final bool isUpdate;
}

final class ExtensionCardError extends ExtensionCardState {
  const ExtensionCardError({required this.isUpdate})
      : super(1, ProgressButtonState.failed);

  final bool isUpdate;

  @override
  List<Object> get props => [isUpdate];
}
