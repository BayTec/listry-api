import 'dart:io';

import 'database/database.dart';
import 'database/postgres_database.dart';

Database getDatabase() => PostgresDatabase(
      Platform.environment['DATABASE_HOST'] ?? '',
      int.tryParse(Platform.environment['DATABASE_PORT'] ?? '0') ?? 0,
      Platform.environment['DATABASE_NAME'] ?? '',
      Platform.environment['DATABASE_USERNAME'] ?? '',
      Platform.environment['DATABASE_PASSWORD'] ?? '',
    );
