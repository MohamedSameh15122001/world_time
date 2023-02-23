import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:world_time/main_cubit.dart';
import 'package:world_time/states.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    MainCubit ref = MainCubit.get(context);
    return Scaffold(
      extendBodyBehindAppBar: true,
      // appBar: AppBar(
      //   elevation: 0,
      //   title: const Text(
      //     'World Time',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   centerTitle: true,
      // ),
      body: BlocConsumer<MainCubit, MainStates>(
        bloc: MainCubit.get(context)..fetchData(),
        listener: (context, state) {
          // if (state is SuccessHomeState) {
          //   state.jsonData;
          // }
        },
        builder: (context, state) {
          return ref.allContinents.isEmpty ||
                  state is LoadingHomeState ||
                  ref.time == null
              ? const SpinKitHourGlass(
                  color: Colors.blue,
                  size: 50.0,
                )
              : Stack(
                  children: [
                    // Container(
                    //   color: Colors.blue,
                    // ),
                    ref.time.contains('AM')
                        ? Image.asset(
                            'lib/assets/am.jpg',
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'lib/assets/pm.jpg',
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.blue.shade700,
                                    Colors.blue.shade500,
                                    Colors.blue.shade300,
                                  ],
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: DropdownButton<String>(
                                dropdownColor: Colors.black,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                                value: ref.selectedContinent,
                                onChanged: (newValue) async {
                                  await ref.changeContinent(newValue);

                                  await ref.fetchCities(ref.selectedContinent);
                                  await ref.changeCity(ref.allCities[0]);
                                  String continentAndCity =
                                      '${ref.selectedContinent}/${ref.selectedCity}';
                                  await ref.fetchTime(continentAndCity);
                                },
                                items: ref.allContinents
                                    .map<DropdownMenuItem<String>>((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                            ref.allCities.isEmpty || state is LoadingCitiesState
                                ? const SpinKitHourGlass(
                                    color: Colors.blue,
                                    size: 50.0,
                                  )
                                : Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.blue.shade700,
                                          Colors.blue.shade500,
                                          Colors.blue.shade300,
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: DropdownButton<String>(
                                      dropdownColor: Colors.black,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      value: ref.selectedCity,
                                      onChanged: (newValue) async {
                                        await ref.changeCity(newValue);
                                        await ref
                                            .fetchCities(ref.selectedContinent);
                                        String continentAndCity =
                                            '${ref.selectedContinent}/${ref.selectedCity}';
                                        await ref.fetchTime(continentAndCity);
                                      },
                                      items: ref.allCities
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                          ],
                        ),
                        ref.time == null || state is LoadingTimeState
                            ? const SpinKitHourGlass(
                                color: Colors.blue,
                                size: 50.0,
                              )
                            : Text(
                                ref.time,
                                style: const TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900),
                              )
                      ],
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: AppBar(
                        title: const Text(
                          'World Time',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        centerTitle: true,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.blue.shade700,
                              Colors.blue.shade500,
                              Colors.blue.shade300,
                            ],
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: const Text(
                            'Made By Mohamed Sameh',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }
}


//this design to end of the page about the person who made the app
// Container(
//   width: double.infinity,
//   decoration: BoxDecoration(
//     gradient: LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [
//         Colors.blue.shade700,
//         Colors.blue.shade500,
//         Colors.blue.shade300,
//       ],
//     ),
//   ),
//   child: Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Text(
//           'Thank you for using our app!',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 24,
//             fontWeight: FontWeight.bold,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 16),
//         Text(
//           'Follow us on social media for more updates and news.',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//           ),
//           textAlign: TextAlign.center,
//         ),
//         SizedBox(height: 16),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.facebook, color: Colors.white),
//             ),
//             SizedBox(width: 16),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.twitter, color: Colors.white),
//             ),
//             SizedBox(width: 16),
//             IconButton(
//               onPressed: () {},
//               icon: Icon(Icons.instagram, color: Colors.white),
//             ),
//           ],
//         ),
//       ],
//     ),
//   ),
// ),
