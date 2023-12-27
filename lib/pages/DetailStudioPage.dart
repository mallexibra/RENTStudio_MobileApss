import 'package:flutter/material.dart';
import 'package:rent_mobileapps/components/Layout.dart';

class DetailStudioPage extends StatefulWidget {
  const DetailStudioPage({super.key});

  @override
  State<DetailStudioPage> createState() => _DetailStudioPageState();
}

class _DetailStudioPageState extends State<DetailStudioPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Layout(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.maxFinite,
            height: 178,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                "https://images.unsplash.com/photo-1702933018110-883638b70eeb?q=80&w=1470&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          Row(
            children: [
              Text(
                "RENT Studio",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 12,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4, horizontal: 7),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.green),
                child: Text(
                  "Tersedia",
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.location_on_sharp,
                size: 18,
              ),
              Text(
                "Kab. Banyuwangi",
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ],
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Deskripsi",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text("Hello world"),
          SizedBox(
            height: 12,
          ),
          Text(
            "Jam Buka",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text("09.00 - 17.00"),
          SizedBox(
            height: 12,
          ),
          Text(
            "Peralatan",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [Text("- Gitar"), Text("- Drumb")],
          ),
          SizedBox(
            height: 12,
          ),
          Text(
            "Review and Rating",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900),
          ),
          SizedBox(
            height: 8,
          ),
          Column(
            children: [
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(66, 205, 205, 205),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?q=80&w=1448&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Keren",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text("Rating: "),
                            Icon(Icons.star_rate_rounded,
                                color: Colors.amber, size: 18),
                            Text("4")
                          ],
                        ),
                        Text("Wah studionya bagus banget dan bersih juga")
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(66, 205, 205, 205),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          "https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?q=80&w=1448&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "User Keren",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            Text("Rating: "),
                            Icon(Icons.star_rate_rounded,
                                color: Colors.amber, size: 18),
                            Text("4")
                          ],
                        ),
                        Text("Wah studionya bagus banget dan bersih juga")
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      )),
      // bottomNavigationBar: Container(
      //     width: double.maxFinite,
      //     height: 65,
      //     padding: EdgeInsets.all(8),
      //     color: Colors.white,
      //     child: Row(
      // crossAxisAlignment: CrossAxisAlignment.start,
      // children: [
      //   Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         "Total Price",
      //         style: TextStyle(
      //             fontWeight: FontWeight.bold, color: Colors.black54),
      //       ),
      //       Text(
      //         "Rp. 20.000",
      //         style: TextStyle(fontWeight: FontWeight.bold),
      //       )
      //     ],
      //   ),
      //   SizedBox(
      //     width: 12,
      //   ),
      //   GestureDetector(
      //     onTap: () {},
      //     child: Container(
      //       width: double.maxFinite,
      //       padding: EdgeInsets.all(8),
      //       decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(8),
      //           color: Colors.deepPurple),
      //       child: Text(
      //         "Booking Now",
      //         textAlign: TextAlign.center,
      //         style: TextStyle(
      //             color: Colors.white, fontWeight: FontWeight.w900),
      //       ),
      //     ),
      //   ),
      // ],
      // )
    );
  }
}
