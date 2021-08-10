import 'package:amit_project/Model/Category/Category.dart';
import 'package:amit_project/Model/Category/CategoryApi.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> with AutomaticKeepAliveClientMixin<Categories> {

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
  Future<List<CategoryElement>> _categoryElements;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _categoryElements = getCategories();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return WillPopScope(
      onWillPop: () => null,
      child: SafeArea(
          child: Scaffold(
              appBar: AppBar(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(7),
                    bottomLeft: Radius.circular(10))),
                automaticallyImplyLeading: false,
                elevation: 5,
                centerTitle: true,
                backgroundColor: Color(0xFF192a56),
                title: Text(
                  "Categories",
                  style: GoogleFonts.quicksand(),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: FutureBuilder(
                    future: _categoryElements,
                    builder: (BuildContext context,AsyncSnapshot<List<CategoryElement>>snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting)return Center(child: Container());
                      else if(snapshot.connectionState==ConnectionState.done&&snapshot.data==null||snapshot.hasError){return Text("error");}
                      else return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              mainAxisExtent: 240, crossAxisCount: 2),
                          itemBuilder: (BuildContext context, int index) {return Card(
                            child: InkWell(
                              child: Card(
                                child: Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          colorFilter:
                                          ColorFilter.mode(
                                              Colors.black12, BlendMode.overlay),
                                          fit: BoxFit.cover,
                                          image: NetworkImage(snapshot.data[index].avatar))
                                  ),
                                  child: Container(
                                    color: Colors.black54,
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15, right: 135),
                                          child: CircleAvatar(
                                            backgroundColor: Color(0xFF192a56),
                                            radius: 12,
                                            child: Text(
                                              snapshot.data[index].id.toString(),
                                              style: TextStyle(
                                                  color: Colors.white70),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(top: 60),
                                          child: Text(
                                              snapshot.data[index].name,
                                              style: GoogleFonts.quicksand(
                                                  color: Colors.white, fontSize: 20)
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );},
                          itemCount: snapshot.data.length,);

                    }
                ),
              ))),
    );
  }


}
