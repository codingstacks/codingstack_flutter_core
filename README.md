# Flutter Core 

This flutter core package with some cooked code to kick-start any project from scratch.

## Features

 - Super Easy Network Call by Dio
 - View Model by GetX
 - Utilities Methods
 - Easy Model Parsing

## Getting started

     dependencies:
        hudle_core:
            git:
               url: git://github.com/codingstacks/codingstack_flutter_core
               ref: 4a3f06178c95f4d88872e37e0b80e851b332bd84 #(Optional, Use latets commit id for latest update.)



`Note: Please take care of indentation while copy pasting in your project dependency`

## Usage

### Register Api Service
Create abstract class and extend with `BaseApiService` and register all your apis
```dart
//Register Apis
abstract class ApiService extends BaseApiService {
  Future<ApiResponse<List<User>>> getAllUsers();
}

```

### Implementation of ApiService
Create abstract class such as ApiProvider and extend with `ApiService` and implement all methods
call the method using dio and just add `.safeApiCall(this)` in last
```dart
//Call Api using Dio
class ApiProvider extends ApiService {

  late Dio dio;

  ApiProvider(String baseUrl) {
    dio = Dio(
      BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type' : 'application/json'
          }
      ),
    )..interceptors.add(
      PrettyDioLogger(
          requestBody: kDebugMode,
          requestHeader: kDebugMode,
          responseBody: kDebugMode),
    );

    //You can remove logger
    //If you do not found imports for pretty logger make sure you have added
    //pretty_dio_logger: ^1.1.1 in dev_dependencies
  }

  @override
  Parser<T> provideParser<T>() {
    return ModelParser();
  }

  @override
  Future<ApiResponse<List<User>>> getAllUsers() {
    return dio.get('users').safeApiCall(this);
  }
}
```

### Creating a Parser class for parsing json response into Model.
Create a class and  extend `Parser` and override `parse(Map<String, dynamic> response)` method.
Make sure you class should be Generic.

- To parse list of response use `isSubtype<T, List<YOU_MODEL>()` Method.
- To parse a model `T == YOU_MODEL`
```dart
///This is parser class where you will define how model will parse
class ModelParser<T> extends Parser<T> {
  @override
  T? parse(Map<String, dynamic> response) {
    T? t;

    if (isSubtype<T, List<User>>()) {
      final list = <User>[];
      response['YOUR_DATA_KEY'].forEach((element)  {
        final data = User.fromJson(element);
        list.add(data);
      });

      t = list as T;
    }

    if (T == User) {
      return User.fromJson(json[key]) as T;
    }

    return t;
  }
}
```

### Creating a repository and calling Apis.
Call any api using `apiService` and use `toResource` or `toResourcePaginate()` to convert the response into  `Resource<T>` class.

- `toResource` will just convert you `ApiResponse<T>` to  `Resource<T>`.
- `toResourcePaginate()` is do the same job (`Resource<PaginationData<T>>)` but if your api response containing pagination data, it will give you the wrapper of your Model `T` and `Meta` class.

```dart
class UserRepository {
    final ApiService apiService;

    UserRepository(this.apiService);

    Future<Resource<List<User>>> getUsers() {
        return apiService.getAllUsers().toResource;
    }

    Future<Resource<PaginationData<User>>> getUsersPaginate() {
        return apiService.getAllUsers().toResourcePaginate();
    }
}
```

### How to use ViewModel
To create a viewModel class extend `BaseViewModel`, see the below example.

```dart
class UserViewModel extends BaseViewModel {
  final UserRepository repository = UserRepository(ApiProvider('YOUR_BASE_URL'));

  final users = <User>[].obs;

  void getUsers() async{
      notifyLoader(true);
      final resource = await repository.getUsers();
      notifyLoader(false);

      if (resource.status == Status.success) {
         users.value = resource.data!;
      }
      else {
        notifyError(resource.error);
      }
    }


}
```

`notifyLoader(true)` will notify your ui the api is loading and `notifyError` will show error page if you are using `ViewModelConsumer` in your UI Widget.

### Using ViewModel in Flutter Screen
```dart
class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late UserViewModel viewModel;

  @override
  void initState() {
    viewModel = UserViewModel();
    viewModel.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelConsumer(
      viewModel: viewModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Users"),
        ),
        body: Obx(
              () => ListView.builder(
            itemCount: viewModel.users.length,
            itemBuilder: (_, index) {
              final user = viewModel.users[index];
              return ListTile(
                title: Text(user.name),
              );
            },
          ),
        ),
      ),
    );
  }
}

```

## Additional information


To get view model in you child class use `ViewModelProvider.of(context)` but make sure your parent class is using `ViewModelConsumer` or `ViewModelProvider`.

## Shortcut Templates
Write abbreviation and hit tab to complete you boilerplate code.

Download template from this [link](https://codingstack.tech/dev/flutter/livetemplate/settings.zip), and import into your Intellij or Android Studio IDE.

See How to import [Click Here](https://www.jetbrains.com/help/go/sharing-live-templates.html#import)



1. `aps` to generate `ApiService` class
2. `repo` it will generate code for `Repository`
3. `bvm` it will generate `ViewModel` for you.
4. `csp` it will generate Stateful Screen Page with included boilerplate code.
5. `api` use this abbreviation inside `ApiService` class to generate one method to register
6. `res` use this abbreviation inside `Repository` to complete you resource method.
7. `resp` use this abbreviation inside `Repository` to complete you resource with `PaginationData` method.
8. `apivm` to call your method in `ViewModel`, it will generate boilerplate code.


