# Welcome to EnterpriseAlumni Flutter Assessment

## Introduction

Consider this assignment as a regular development task that you would receive if you were part of our team. You are free to read documentation, access stackoverflow, and use Google basically. But please refrain from using ChatGPT and similar AI solutions to generate an implementation. We need to evaluate "your" ability to understand the task and provide solution for it.

## Description

This is a basic project that already has a simple Login and Profile screen. We use the DummyJson api, please take a look at https://dummyjson.com/docs.

For state management we are using flutter_hooks, you can see more info here https://github.com/rrousselGit/flutter_hooks.
We have custom hooks to help us with async operations, please take a look at /lib/utils/ut_custom_hooks.dart to understand how to use it.

## Tasks

We need to add screens in this app in order to make CRUD operations for Products api - https://dummyjson.com/docs/products

### Bonus task

This App is requiring Login every time the user reload it. We need a way to persist authentication.

## Getting Started

### Run

To run this project you need to install FVM(Flutter version manager)

https://fvm.app/documentation/getting-started/installation

Then run

```
fvm flutter run
```

To login in the App you could use this creadentials

```
kminchelle
0lelplR
```

## Additional Information - From Thiago

### Video Demo

A video with the running solution has been recorded and is available [here](https://www.loom.com/share/5fc1d876609748bfb0586d07c1c43854). The CRUD project requirement and the bonus task (session management) are completed.

### Task management

I managed the tasks using github milestone and issues sections. For more details about how they were broken up, please, take a look at these sections.

### Important Notes

I wish I had more time to enhance these aspects:

- There are some "naming conventions" in the provided project that do not adhere to Dart's standards. I would refactor them;
- Hooks do not scale well for "big" projects. As the project grows, managing numerous hooks across different components can become complex. In my honest view, they become challenging to read and maintain. I would refactor to use Riverpod (for both state management and dependency injection - service locator). I would reserve hooks for specific scenarios. Note: though StatefulHookConsumerWidget and HookConsumerWidget, we can also use tradicional hooks inside "Riverpod"/"Provider" widgets;
- I would segregate the "data layer" (`ut_dummy_json_api.dart`) based on the "Aggregates" concept (from the DDD - Domain-driven Design) in a more complex project. For instance, one `ut_dummy_json_api.dart` for login; another `ut_dummy_json_api.dart` file for products. I wouldn't mix them in one specific file. Using service locator e.g.; Riverpod/provider, we can locate the specific API;
- I used default Flutter's Navigation. But I would use GoRouter package;
- Automated testing is crucial. However, it could require significantly more time to complete and necessitate substantial changes to prioritize SOLID principles and streamline test inclusion.
- Last, but not least, I love the "monorepo" approach. The [melos package](https://pub.dev/packages/melos) is an excelent tool for monorepo Flutter projects. I've been using it a lot! Authentication and Products would be two different and independent packages that can be reused in different apps, but both resides into the same "project".

Many improvements can be made to enhance the readability and maintainability of this code. :).

I hope we can discuss about the aforementioned things later.

Sincerely,
Thiago.

## Additional Information - Part 2 - Improvements from Thiago

### Video Demo

A video with the running solution has been recorded and is available [here](https://www.loom.com/share/e846575dbf224a9a83f9d1500cc31e6a). The CRUD project requirement and the bonus task (session management) are completed.

### Important Notes

In the previous section, I described some important aspects that could be done as improvements. Since I wasn't sure how long time I had to finish the first version of the assessment, I decided to do the "basics" for finishing the assessment, including the requirements requested.

During this weekend, I decided to make some of the improvements I detailed before, which are described as follows:

1. Lack of flexibility to replace HTTP API tools: the first version uses Dio, and if we have any other newer package in the future, it would require a lot of work to replace Dio with the newer one.

Now we have the `http_client`, which provides the minimal requirement for HTTP API. As an implementation example, the `dio_http_client` is an implementation of `http_client` using Dio. See also the `test` folder with some basic tests files. An API management is responsible for building an specific http client `strategy`.

2. Routing using the GoRoute package: as detailed in the demo video, GoRoute allows specifying routes and redirections.

3. Authentication, Profile and Products can be seen as independent `modules`. They have their own data, domain, presentation and route responsabilities (S from SOLID).
