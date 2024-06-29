part of 'discover_content_cubit.dart';

sealed class DiscoverContentState extends Equatable {
  const DiscoverContentState();
}

final class DiscoverContentInitial extends DiscoverContentState {
  const DiscoverContentInitial({
    this.spotlightsLoading = true,
    this.mostPopularLoading = true,
    this.recentlyUpdatedLoading = true,
    this.spotlights = const [],
    this.mostPopular = const [],
    this.recentlyUpdated = const [],
  });

  // * Loading states
  final bool spotlightsLoading;
  final bool mostPopularLoading;
  final bool recentlyUpdatedLoading;

  // * Novels
  final List<Novel> spotlights;
  final List<Novel> mostPopular;
  final List<Novel> recentlyUpdated;

  @override
  List<Object> get props => [
        spotlightsLoading,
        mostPopularLoading,
        recentlyUpdatedLoading,
        spotlights,
        mostPopular,
        recentlyUpdated,
      ];

  DiscoverContentInitial copyWith({
    bool? spotlightsLoading,
    bool? mostPopularLoading,
    bool? recentlyUpdatedLoading,
    List<Novel>? spotlights,
    List<Novel>? mostPopular,
    List<Novel>? recentlyUpdated,
  }) {
    return DiscoverContentInitial(
      spotlightsLoading: spotlightsLoading ?? this.spotlightsLoading,
      mostPopularLoading: mostPopularLoading ?? this.mostPopularLoading,
      recentlyUpdatedLoading:
          recentlyUpdatedLoading ?? this.recentlyUpdatedLoading,
      spotlights: spotlights ?? this.spotlights,
      mostPopular: mostPopular ?? this.mostPopular,
      recentlyUpdated: recentlyUpdated ?? this.recentlyUpdated,
    );
  }
}

final class DiscoverContentError extends DiscoverContentState {
  const DiscoverContentError(this.error);

  final Exception error;

  @override
  List<Object> get props => [error];
}
