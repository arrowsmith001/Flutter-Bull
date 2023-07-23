import 'entity.dart';
import 'repository.dart';

abstract class EntityService<T extends Entity> 
{
  EntityService(this.entityStore); 

  final Repository<T> entityStore;
  int get entityCount => entityStore.cacheCount;
}