import { BooleanLike } from 'common/react';

export type SecurityRecordsData = {
  assigned_view: string;
  authenticated: BooleanLike;
  station_z: BooleanLike;
  available_statuses: string[];
  current_user: string;
  higher_access: BooleanLike;
  records: SecurityRecord[];
  min_age: number;
  max_age: number;
  max_chrono_age: number; // SKYRAT EDIT ADDITION - Chronological age
};

export type SecurityRecord = {
  age: number;
  chrono_age: number; // SKYRAT EDIT ADDITION - Chronological age
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
  // SKYRAT EDIT START - RP Records
  past_general_records: string;
  past_security_records: string;
  // SKYRAT EDIT END
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
