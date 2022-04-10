import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
// void main() {
//   print(getToiletImageUrlList("https://www.toilet.org.sg/gallery/202/4-star-toilet-dt20-fort-canning-station"));
// }

/// Gets all the image urls on toilet.org.sg given the [toiletAlbumLink]
/// Returns a list of url strings
Future<List?> getToiletImageUrlList(String toiletAlbumLink) async {
  // Download the content of the site
  http.Response response = await http.get(Uri.parse(toiletAlbumLink));
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    String html = response.body;
    //print(html);

    // Html package guarantees a parsing of any HTML
    var document = parse(html);
    // print(document.outerHtml);

    // Get the TagName, ClassName, or Id in the DOM

    // for loop from 0 to end (break when error)
    int i = 0;
    //final ImageURLList = <String>[]; // Creates growable list.
    List<String> ImageURLList = [];
    // Loop through the html and get all the toilet image links
    while (true) {
      try {
        var link = document.getElementsByClassName('project-thumb')[i].children[0];
        var text = link.attributes['src'];
        
        String toiletImagesLink = "https://www.toilet.org.sg/" + text!;
        http.Response response1 = await http.get(Uri.parse(toiletImagesLink));
        if (response1.statusCode == 200) {
          ImageURLList.add(toiletImagesLink);
          // print("Comment: One toilet image link added to list");
        }

        else {
          throw Exception('Comment: Failed to load toilet images using the full toilet image link');
        }
        i++;

        // Loop will break when there is an exception (of range error?)
      } catch (e) {
        print(e);
        print("Comment: Range error means there are no more links");
        break;
      } 
      
    }
    // print(ImageURLList);
    return  ImageURLList;
    
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Comment: Failed to load toilet album on toilet.org');
  }
}