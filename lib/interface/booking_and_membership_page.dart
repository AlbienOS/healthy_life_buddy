import 'package:flutter/material.dart';
import 'package:healthy_life_buddy/common/state.dart';
import 'package:healthy_life_buddy/provider/booking_provider.dart';
import 'package:healthy_life_buddy/widget/error_state_message.dart';
import 'package:healthy_life_buddy/widget/headline_widget.dart';
import 'package:healthy_life_buddy/widget/no_data_state_message.dart';
import 'package:healthy_life_buddy/widget/user_profile_widget.dart';
import 'package:provider/provider.dart';

class BookingAndMembershipPage extends StatelessWidget {
  const BookingAndMembershipPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                UserProfile(),
                Headline(text: 'Pesanan Tempat Kamu'),
                ListOfBookingSportsVenues(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListOfBookingSportsVenues extends StatelessWidget{
  const ListOfBookingSportsVenues({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
   return Consumer<BookingSportsVenueProvider>(
       builder: (context, snapshot, _){
     final bookingSportVenues = snapshot.bookingSportsData;
     var currentState = snapshot.state;
     if(currentState == CurrentState.isLoading){
       return Center(
               child: CircularProgressIndicator()
       );
     }
     else if(currentState == CurrentState.hasData){
       return ListView.builder(
           itemCount: bookingSportVenues.length,
             itemBuilder: (context, i){
              return Card(
               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)
               ),
                child: Row(
                  children: [
                    Padding(padding: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(bookingSportVenues[i].name),
                      ),
                    ),
                  ],
                ),
             );
         });
     }
     else if(currentState == CurrentState.noData){
       return  NoDataStateMessage();
     }
     else if(currentState == CurrentState.isError){
       return ErrorStateMessage();
     }
     else{
       return Container();
     }
    },
   );
  }

}
