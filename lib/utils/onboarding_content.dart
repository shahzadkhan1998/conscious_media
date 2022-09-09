
import 'images.dart';

class UnbordingContent {
  String? image;
  String? title;
  String? discription;
  // bool? check;

  UnbordingContent({this.image, this.title, this.discription /*, this.check*/});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Hello amazing',
      image: Images.splash_logo,
      discription: "We couldn't be more thrilled to see you here!"),
  UnbordingContent(
      title: 'Do you want to take a share in making the world a better place?',
      image: Images.splash_logo,
      discription:
          "Join us to swap ideas, projects, experiences and to find inspiration every day! Upload and share anything related: pictures, videos, ideas, events, news, podcasts or anything you just like!"),
  UnbordingContent(
      title:
          'A platform where everything supports the benefit of humanity and the planet',
      image: Images.splash_logo,
      discription: ""),
  UnbordingContent(
      title: 'Welcome on CM!',
      image: Images.splash_logo,
      discription: "Welcome on the real \nsocial media"),
];
