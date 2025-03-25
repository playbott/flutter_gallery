import 'package:photo_gallery/bloc/bloc.dart';
import 'package:photo_gallery/presentation/widgets/widgets.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key, required this.appTitle});

  final String appTitle;

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  void initState() {
    productBloc.add(FetchProducts());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.appTitle),
        actions: [
          BlocBuilder<NetworkStatusBloc, NetworkStatusState>(
            bloc: networkStatusBloc,
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Row(
                  children: [
                    NetworkStatusWidget(),
                    if (state is NetworkStatusOnline)
                      IconButton(
                        onPressed: () => productBloc.add(FetchProducts()),
                        icon: Icon(Icons.refresh),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<NetworkStatusBloc, NetworkStatusState>(
        bloc: networkStatusBloc,
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              if (state is NetworkStatusOnline) {
                productBloc.add(FetchProducts());
              }
            },
            child: BlocBuilder<ProductBloc, ProductState>(
              bloc: productBloc,
              builder: (context, state) {
                if (state is ProductNotInitialized) {
                  return const Center(child: Text('Tap to get products'));
                } else if (state is ProductLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ProductCompleted) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(20.0),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200.0,
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 1.0,
                        ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      return PhotoWidget(photo: state.products[index]);
                    },
                  );
                } else if (state is ProductFailed) {
                  return Center(child: Text(state.message));
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }
}
