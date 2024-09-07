import { BooleanLike } from 'common/react';

export type SecurityRecordsData = {
  assigned_view: string;
  authenticated: BooleanLike;
<<<<<<< HEAD
=======
  station_z: BooleanLike;
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
  available_statuses: string[];
  current_user: string;
  higher_access: BooleanLike;
  records: SecurityRecord[];
  min_age: number;
  max_age: number;
<<<<<<< HEAD
  max_chrono_age: number; // SKYRAT EDIT ADDITION - Chronological age
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
};

export type SecurityRecord = {
  age: number;
<<<<<<< HEAD
  chrono_age: number; // SKYRAT EDIT ADDITION - Chronological age
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
  citations: Crime[];
  crew_ref: string;
  crimes: Crime[];
  fingerprint: string;
  gender: string;
  name: string;
  note: string;
  rank: string;
  species: string;
  trim: string;
  wanted_status: string;
  voice: string;
<<<<<<< HEAD
  // SKYRAT EDIT START - RP Records
  past_general_records: string;
  past_security_records: string;
  // SKYRAT EDIT END
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
};

export type Crime = {
  author: string;
  crime_ref: string;
  details: string;
  fine: number;
  name: string;
  paid: number;
  time: number;
  valid: BooleanLike;
  voider: string;
};

export enum SECURETAB {
  Crimes,
  Citations,
  Add,
}

export enum PRINTOUT {
  Missing = 'missing',
  Rapsheet = 'rapsheet',
  Wanted = 'wanted',
}
