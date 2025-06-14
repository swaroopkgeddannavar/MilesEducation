import 'package:flutter_test/flutter_test.dart';
import 'package:miles_educations/core/services/fire_store_services.dart';
import 'package:mockito/mockito.dart';
import 'package:miles_educations/features/home/data/model/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'test_task_services.mocks.dart';


void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockFirebaseAuth mockAuth;
  late MockCollectionReference mockCollection;
  late MockUser mockUser;
  late TaskService service;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockAuth = MockFirebaseAuth();
    mockCollection = MockCollectionReference();
    mockUser = MockUser();

    when(mockFirestore.collection('tasks')).thenReturn(mockCollection as CollectionReference<Map<String, dynamic>>);
    when(mockAuth.currentUser).thenReturn(mockUser);
    when(mockUser.uid).thenReturn('testUserId');

    service = TaskService(firestore: mockFirestore, auth: mockAuth);
  });

  test('addTask adds task to Firestore', () async {
    final task = Task(id: '1', title: 'Test', description: 'Desc', userId: 'testUserId');

    when(mockCollection.add(any)).thenAnswer((_) async => MockDocumentReference());

    await service.addTask(task);

    verify(mockCollection.add(task.toJson())).called(1);
  });

  test('deleteTask deletes task by ID', () async {
    final mockDocRef = MockDocumentReference();
    when(mockCollection.doc('1')).thenReturn(mockDocRef);
    when(mockDocRef.delete()).thenAnswer((_) async => {});

    await service.deleteTask('1');

    verify(mockDocRef.delete()).called(1);
  });

  test('updateTask updates task by ID', () async {
    final task = Task(id: '1', title: 'Updated', description: 'Desc', userId: 'testUserId');
    final mockDocRef = MockDocumentReference();

    when(mockCollection.doc('1')).thenReturn(mockDocRef);
    when(mockDocRef.update(any)).thenAnswer((_) async => {});

    await service.updateTask(task);

    verify(mockDocRef.update(task.toJson())).called(1);
  });

  test('getTasks returns stream of tasks', () async {
    final mockQuery = MockQuery();
    final mockSnapshot = MockQuerySnapshot();
    final mockDoc = MockQueryDocumentSnapshot();

    when(mockCollection.where('userId', isEqualTo: 'testUserId')).thenReturn(mockQuery);
    when(mockQuery.snapshots()).thenAnswer((_) => Stream.value(mockSnapshot));
    when(mockSnapshot.docs).thenReturn([mockDoc]);

    when(mockDoc.data()).thenReturn({
      'id': '1',
      'title': 'Task Title',
      'description': 'Task Desc',
      'userId': 'testUserId'
    });

    final tasksStream = service.getTasks();

    await expectLater(tasksStream, emits(isA<List<Task>>()));
  });

}
