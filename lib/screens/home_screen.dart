
import 'package:flutter/material.dart';
import 'package:toonflix/services/api_service.dart';
import 'package:toonflix/widgets/webtoon_widget.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final Future webtoons = ApiService.getTodaysToons();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        foregroundColor: Colors.green, // 폰트 색상 지정
        title: const Text(
          '오늘의 웹툰',
          style: TextStyle(
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        //Future 만의 builder
        future: webtoons,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // Future 완료 후 데이터가 존재한다면
            return Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                Expanded(child: makeList(snapshot)),
                //Listview인 makeList가 무한 높이라 어느정도로 하기 위해 expanded사용
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  ListView makeList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.separated(
      // 사용자가 보고 있는 데이터만 build
      // list를 재사용 (index번호가 끝없이 늘어나는게 x)
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),

      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      itemBuilder: (context, index) {
        // item을 호출하는 함수
        var webtoon = snapshot.data![index];
        return Webtoon(
          title: webtoon.title,
          thumb: webtoon.thumb,
          id: webtoon.id,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 40,
      ),
      //separatorBuilder는 item를 구별하기 위해 사이에 위젯을 생성
    );
  }
}
