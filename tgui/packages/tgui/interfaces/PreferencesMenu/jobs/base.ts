import { Department } from "./departments";

export type Job = {
  name: string;
  description: string;
  department: Department;
// SKYRAT EDIT
  veteran?: boolean;
  alt_titles?: string[];
// SKYRAT EDIT END
};
