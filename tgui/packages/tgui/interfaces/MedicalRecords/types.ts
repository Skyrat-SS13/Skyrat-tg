import { BooleanLike } from 'common/react';

export type MedicalRecordData = {
  assigned_view: string;
  authenticated: BooleanLike;
  station_z: BooleanLike;
  physical_statuses: string[];
  mental_statuses: string[];
  records: MedicalRecord[];
  min_age: number;
  max_age: number;
  max_chrono_age: number; // SKYRAT EDIT ADDITION - Chronological age
};

export type MedicalRecord = {
  age: number;
  chrono_age: number; // SKYRAT EDIT ADDITION - Chronological age
  blood_type: string;
  crew_ref: string;
  dna: string;
  gender: string;
  major_disabilities: string;
  minor_disabilities: string;
  physical_status: string;
  mental_status: string;
  name: string;
  notes: MedicalNote[];
  quirk_notes: string;
  rank: string;
  species: string;
  trim: string;
  // SKYRAT EDIT START - RP Records
  past_general_records: string;
  past_medical_records: string;
  // SKYRAT EDIT END
};

export type MedicalNote = {
  author: string;
  content: string;
  note_ref: string;
  time: string;
};
