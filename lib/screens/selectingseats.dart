import 'package:flutter/material.dart';
import 'package:movie_test/models/movie.model.dart';
import 'package:movie_test/screens/moviedetails.screen.dart';

class SelectingSeats extends StatelessWidget {
  final MovieResultsModel movieResultsModel;
  SelectingSeats({Key? key, required this.movieResultsModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Column(children: [
          Text(
            movieResultsModel.title ?? "",
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(
            height: 7,
          ),
          Text(
            ("In Theaters ${formatDate(movieResultsModel.releaseDate)}"),
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: Colors.blue,
            ),
          ),
        ]),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        decoration:
                            BoxDecoration(color: const Color(0xFFF6F6FA)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Image.asset(
                                'assets/images/seats_big.png',
                                fit: BoxFit.fill,
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Divider(
                                thickness: 5,
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        bottom: 50,
                        child: Image.asset("assets/images/seat_details.png"),
                      ),
                      Positioned(
                        bottom: 5,
                        right: 5,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: const Icon(
                                  (Icons.add),
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.all(5),
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: const Icon(
                                  Icons.remove,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(margin: EdgeInsets.all(10), child: const WidgetSeat()),
          const SizedBox(
            height: 20,
          ),
          const WidgetRow(),
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.07,
              ),
              Container(
                width: 108,
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 108,
                        height: 50,
                        decoration: ShapeDecoration(
                          color: Color(0x19A5A5A5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 22,
                      child: Text(
                        '\$ 50',
                        style: TextStyle(
                          color: Color(0xFF202C43),
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0.08,
                          letterSpacing: 0.20,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 20,
                      top: 9,
                      child: Text(
                        'Total Price',
                        style: TextStyle(
                          color: Color(0xFF202C43),
                          fontSize: 10,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          height: 0.10,
                          letterSpacing: -0.20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
              ),
              Container(
                width: 216,
                height: 50,
                child: Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 216,
                        height: 50,
                        decoration: ShapeDecoration(
                          color: Color(0xFF61C3F2),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 53,
                      bottom: 0,
                      top: 25,
                      child: Text(
                        'Proceed to pay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          height: 0.10,
                          letterSpacing: 0.20,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Spacer()
        ],
      ),
    );
  }
}

class WidgetRow extends StatelessWidget {
  const WidgetRow({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 97,
      height: 30,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: 97,
              height: 30,
              decoration: ShapeDecoration(
                color: const Color(0x19A5A5A5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),
          Positioned(
            left: 79.59,
            top: 7,
            child: Transform(
              transform: Matrix4.identity()
                ..translate(0.0, 0.0)
                ..rotateZ(0.79),
              child: Container(
                width: 10.73,
                height: 10.73,
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(),
                child: Stack(
                  children: [
                    Positioned(
                      left: 0.77,
                      top: 5.37,
                      child: Transform(
                        transform: Matrix4.identity()
                          ..translate(0.0, 0.0)
                          ..rotateZ(-0.79),
                        child: const SizedBox(
                          width: 6.74,
                          height: 6.51,
                          child: Stack(children: []),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Positioned(
            left: 10,
            top: 10,
            bottom: 0,
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '4 ',
                    style: TextStyle(
                      color: Color(0xFF202C43),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      height: 0.07,
                      letterSpacing: -0.20,
                    ),
                  ),
                  TextSpan(
                    text: '/',
                    style: TextStyle(
                      color: Color(0xFF202C43),
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      height: 0.07,
                      letterSpacing: -0.20,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Positioned(
            left: 32,
            top: 10,
            bottom: 0,
            child: Text(
              '3 row',
              style: TextStyle(
                color: Color(0xFF202C43),
                fontSize: 14,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w400,
                height: 0.10,
                letterSpacing: -0.20,
              ),
            ),
          ),
          const Positioned(
              right: 0,
              top: 0,
              bottom: 0,
              child: Icon(
                Icons.close,
                size: 20,
              ))
        ],
      ),
    );
  }
}

class WidgetSeat extends StatelessWidget {
  const WidgetSeat({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260.65,
      height: 53,
      child: Stack(
        children: [
          Positioned(
            left: 143,
            top: 0,
            child: SizedBox(
              width: 109.49,
              height: 19,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 1,
                    child: Opacity(
                      opacity: 0.50,
                      child: SizedBox(
                        width: 17.01,
                        height: 16.16,
                        child: Stack(
                          children: [
                            Positioned(
                              left: 0,
                              top: 0,
                              child: Container(
                                width: 17.01,
                                height: 12.76,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFA5A5A5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(2)),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 2.55,
                              top: 13.61,
                              child: Container(
                                width: 11.91,
                                height: 2.55,
                                decoration: ShapeDecoration(
                                  color: const Color(0xFFA5A5A5),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 28.49,
                    top: 10,
                    child: Text(
                      'Not available',
                      style: TextStyle(
                        color: Color(0xFF8F8F8F),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0.13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              width: 87.35,
              height: 19,
              child: Stack(
                children: [
                  const Positioned(
                    left: 29.85,
                    top: 10,
                    child: SizedBox(
                      width: 57.50,
                      child: Text(
                        'Selected',
                        style: TextStyle(
                          color: Color(0xFF8F8F8F),
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                          height: 0.13,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 1,
                    child: SizedBox(
                      width: 17.01,
                      height: 16.16,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 17.01,
                            height: 12.76,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFCD9D0F),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2)),
                            ),
                          ),
                          Container(
                            width: 11.91,
                            height: 2.55,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFCD9D0F),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 34,
            child: SizedBox(
              width: 90.85,
              height: 19,
              child: Stack(
                children: [
                  const Positioned(
                    left: 23.85,
                    top: 10,
                    child: Text(
                      'VIP (150\$)',
                      style: TextStyle(
                        color: Color(0xFF8F8F8F),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0.13,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 1,
                    child: SizedBox(
                      width: 17.01,
                      height: 16.16,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 17.01,
                            height: 12.76,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF564CA3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                          Container(
                            width: 11.91,
                            height: 2.55,
                            decoration: ShapeDecoration(
                              color: const Color(0xFF564CA3),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 143,
            top: 34,
            child: SizedBox(
              width: 117.65,
              height: 19,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 1,
                    child: SizedBox(
                      width: 17.01,
                      height: 16.16,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 0,
                            top: 0,
                            child: Container(
                              width: 17.01,
                              height: 12.76,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF61C3F2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 2.55,
                            top: 13.61,
                            child: Container(
                              width: 11.91,
                              height: 2.55,
                              decoration: ShapeDecoration(
                                color: const Color(0xFF61C3F2),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(4)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 28.65,
                    top: 10,
                    child: Text(
                      'Regular (50 \$)',
                      style: TextStyle(
                        color: Color(0xFF8F8F8F),
                        fontSize: 12,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0.13,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
