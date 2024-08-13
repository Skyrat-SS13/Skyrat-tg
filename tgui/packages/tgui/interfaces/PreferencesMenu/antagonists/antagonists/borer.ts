import { Antagonist, Category } from '../base';

export const BORER_MECHANICAL_DESCRIPTION = `
A small slithering monster infecting people's brains.
Infect a host, grow and reproduce.
Become a useful aid, empowering your host, or go on a murderous rampage. Rule the station.
`;

const Borer: Antagonist = {
  key: 'borer',
  name: 'Borer',
  description: [BORER_MECHANICAL_DESCRIPTION],
  category: Category.Midround,
  priority: -1,
};

export default Borer;
