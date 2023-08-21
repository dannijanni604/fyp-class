import 'package:cached_network_image/cached_network_image.dart';
import 'package:first_platoon/controllers/manage_controller.dart';
import 'package:flutter/material.dart';

class DocumentView extends StatelessWidget {
  const DocumentView({
    super.key,
    required this.decoments,
    required this.ctrl,
  });
  final List decoments;
  final ManageController ctrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Download To View"),
      ),
      body: decoments.isEmpty
          ? const Center(
              child: Text("No Documents"),
            )
          : GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemCount: decoments.length,
              itemBuilder: ((context, index) {
                final splitpath = decoments[index].split('.').last;
                ctrl.extension = splitpath.split('?').first;
                if (ctrl.extension == "png" ||
                    ctrl.extension == "jpg" ||
                    ctrl.extension == 'jpeg') {
                  return Container(
                      alignment: Alignment.bottomRight,
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 15),
                      padding: const EdgeInsets.all(10),
                      height: 150,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12,
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: CachedNetworkImageProvider(decoments[index],
                              errorListener: () => Icon(Icons.error_outline)),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 18.0, horizontal: 10),
                            child: Text(ctrl.extension),
                          ),
                          IconButton(
                            onPressed: () {
                              ctrl.downloadAndOpenFile(
                                url: decoments[index],
                                fileName: splitpath,
                              );
                            },
                            icon: const Icon(
                              Icons.download,
                              size: 20,
                            ),
                          ),
                        ],
                      ));
                } else {
                  return Container(
                    alignment: Alignment.bottomCenter,
                    margin:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    padding: const EdgeInsets.all(10),
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black12,
                        image: const DecorationImage(
                          fit: BoxFit.fill,
                          // scale: 20,
                          opacity: 0.5,
                          image: AssetImage(
                            "assets/images/file.png",
                          ),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 10),
                          child: Text(ctrl.extension),
                        ),
                        IconButton(
                          onPressed: () {
                            ctrl.downloadAndOpenFile(
                              url: decoments[index],
                              fileName: splitpath,
                            );
                          },
                          icon: const Icon(
                            Icons.download,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
            ),
    );
  }
}
