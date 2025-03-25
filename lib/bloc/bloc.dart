
import 'bloc.dart';
export 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_gallery/data/repositories/repositories.dart';
import 'package:photo_gallery/data/source/remote/remote.dart';

export 'gallery/gallery_bloc.dart';
export 'product/product_bloc.dart';
export 'app/message/message_bloc.dart';
export 'app/network_status/network_status_bloc.dart';

List<BlocProvider> blocProviders = [
  // BlocProvider(lazy: false, create: (_) => galleryBloc),
  BlocProvider(lazy: false, create: (_) => productBloc),
  BlocProvider(lazy: false, create: (_) => globalMessageBloc),
  BlocProvider(lazy: false, create: (_) => networkStatusBloc),
];

GalleryBloc galleryBloc = GalleryBloc(GalleryRepository(GalleryRemote()));
ProductBloc productBloc = ProductBloc(ProductRepository(ProductRemote()));
NetworkStatusBloc networkStatusBloc = NetworkStatusBloc();