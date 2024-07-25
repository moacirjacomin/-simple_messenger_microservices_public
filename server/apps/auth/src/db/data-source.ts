import { DataSource, DataSourceOptions } from "typeorm";
import { UserEntity } from "../../../../libs/shared/src/entities/user.entity";

export const dataSourceOptions: DataSourceOptions = {
    type: 'postgres',
    url: process.env.POSTGRES_URI,
    // synchronize: true, // shouldn't be used in prodution = may lose data
    entities: [UserEntity],
    migrations: ['dist/apps/auth/db/migrations/*.js']
  };

  export const dataSource = new DataSource(dataSourceOptions);