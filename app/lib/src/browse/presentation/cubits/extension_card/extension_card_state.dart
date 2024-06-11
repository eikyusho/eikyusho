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
  const ExtensionCardDownloaded() : super(1, ProgressButtonState.finished);
}

final class ExtensionCardError extends ExtensionCardState {
  const ExtensionCardError(this.message) : super(1, ProgressButtonState.failed);

  final String message;

  @override
  List<Object> get props => [message];
}
