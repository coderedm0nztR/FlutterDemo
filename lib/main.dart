import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_app/user.dart';

void main() => runApp(MyApp(
  model: UserModel(),
));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final UserModel model;
  const MyApp({Key key, @required this.model}) : super(key: key);


  //Always needed to construct widget
  @override
  Widget build(BuildContext c) {
    return ScopedModel<UserModel>(
        model: model,
        child: MaterialApp(
          title: 'Model with Scope Test',
          home: UserHome('User Home')
        )

    );
  }
}

class UserHome extends StatelessWidget{
  final String title;
  Location location = new Location();
   UserHome(this.title);

   @override build(BuildContext c){
     return Scaffold(
       appBar: AppBar(
         title: Text(title)
       ),
       body: Center(
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Text('You have pushed the button this many times:'),
             // Create a ScopedModelDescendant. This widget will get the
             // CounterModel from the nearest parent ScopedModel<CounterModel>.
             // It will hand that CounterModel to our builder method, and
             // rebuild any time the CounterModel changes (i.e. after we
             // `notifyListeners` in the Model).

             ScopedModelDescendant<UserModel>(
               builder: (context, child, model) {
                 return Text(
                   model.id.toString(),
                   style: Theme.of(context).textTheme.display1,
                 );
               },
             ),

             ScopedModelDescendant<UserModel>(
                 builder: (context, child, model){
                   return MaterialButton(
                       child: new Text('Get Current Location'),
                       onPressed: () async{
//                         try {
//                           location.getLocation().then(
//                                   (Map<String, double> x) =>{
//                                      await model.setLocal(x);
//                                   }
//                           ).catchError((Exception e) => {});
//
//                         }catch (e) {
//                            model.setLocal(null);
//                         }
                       Map<String, double> loc;
                       try{
                         loc = await location.getLocation();
                       } on Exception catch (e){
                         loc = null;
                       }
                       model.setLocal(loc);
                       });
                 }),

             Text('Your current geo location: '),
             ScopedModelDescendant<UserModel>(
               builder: (context, child,model){
                 return MaterialButton(
                  onPressed: (){
                    runApp(MyApp(
                        model: model
                    ));
                  }
                 );
             },
             ),
             ScopedModelDescendant<UserModel>(
                 builder: (context, child, model){
                   return Text(
                     model.location.toString(),
                     style: Theme.of(context).textTheme.caption,
                   );
                 }
             )



           ],
         ),
       ),
       backgroundColor: Colors.green,
       // Use the ScopedModelDescendant again in order to use the increment
       // method from the CounterModel
       floatingActionButton: ScopedModelDescendant<UserModel>(
         builder: (context, child, model) {
           return FloatingActionButton(
             onPressed: model.incrementID,
             tooltip: 'Increment this id',
             child: Icon(Icons.add),
           );
         },
       ),

     );
   }
}