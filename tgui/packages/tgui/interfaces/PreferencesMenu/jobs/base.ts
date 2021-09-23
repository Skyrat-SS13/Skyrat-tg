import { Department } from "./departments";

export type Job = {
  name: string;
  description: string;
  department: Department;
  veteran?: boolean;
  alt_titles?: string[];
};
