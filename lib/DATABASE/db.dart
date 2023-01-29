import 'package:drift/drift.dart';
part 'db.g.dart';

class ScannerResult extends Table{
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get description  => text()();


}

abstract class ScannerResultView extends View {
  ScannerResult get scannerResult;
  @override
  Query as() => select([
    scannerResult.title
  ]).from(scannerResult);
}

@DriftDatabase(tables:[ScannerResult],views:[
  ScannerResultView
])

class Database extends _$Database{
  Database(QueryExecutor e):super(e);

  @override
  int get schemaVersion => 2;
}