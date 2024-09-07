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
<<<<<<< HEAD
  max_chrono_age: number; // SKYRAT EDIT ADDITION - Chronological age
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
};

export type MedicalRecord = {
  age: number;
<<<<<<< HEAD
  chrono_age: number; // SKYRAT EDIT ADDITION - Chronological age
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
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
<<<<<<< HEAD
  // SKYRAT EDIT START - RP Records
  past_general_records: string;
  past_medical_records: string;
  // SKYRAT EDIT END
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
};

export type MedicalNote = {
  author: string;
  content: string;
  note_ref: string;
  time: string;
};
