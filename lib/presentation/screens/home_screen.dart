import 'package:photo_gallery/bloc/bloc.dart';
import 'package:photo_gallery/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, required this.appTitle});

  final String appTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(appTitle)),
      body: BlocBuilder<GalleryBloc, GalleryState>(
        bloc: galleryBloc,
        builder: (context, state) {
          if (state is GalleryInitial) {
            galleryBloc.add(FetchPhotos());
            return const Center(child: Text('Press to load photos'));
          } else if (state is GalleryLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GalleryCompleted) {
            return GridView.builder(
              padding: const EdgeInsets.all(20.0),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200.0,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 1.0,
              ),
              itemCount: state.photos.length,
              itemBuilder: (context, index) {
                return PhotoWidget(photo: state.photos[index]);
              },
            );
          } else if (state is GalleryError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
