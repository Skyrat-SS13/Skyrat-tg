import { createSearch } from 'common/string';
import { useState } from 'react';

import { useBackend } from '../backend';
import { Box, Icon, Input, Section } from '../components';
import { NtosWindow } from '../layouts';

export const NtosRecords = (props) => {
  const { act, data } = useBackend();
  const [searchTerm, setSearchTerm] = useState('');
  const { mode, records } = data;

  const isMatchingSearchTerms = createSearch(searchTerm);

  return (
    <NtosWindow width={600} height={800}>
      <NtosWindow.Content scrollable>
        <Section textAlign="center">
          NANOTRASEN PERSONNEL RECORDS (CLASSIFIED)
        </Section>
        <Section>
          <Input
            placeholder={'Filter results...'}
            value={searchTerm}
            fluid
            textAlign="center"
            onChange={(e, value) => setSearchTerm(value)}
          />
        </Section>
        {mode === 'security' &&
          records.map((record) => (
            <Section
              key={record.id}
              hidden={
                !(
                  searchTerm === '' ||
                  isMatchingSearchTerms(
                    record.name +
                      ' ' +
                      record.rank +
                      ' ' +
                      record.species +
                      ' ' +
                      record.gender +
                      ' ' +
                      record.age +
                      ' ' +
                      /* SKYRAT EDIT ADDITION BEGIN - Chronological age */
                      record.chrono_age +
                      ' ' +
                      /* SKYRAT EDIT ADDITION END */
                      record.fingerprint,
                  )
                )
              }
            >
              <Box bold>
                <Icon name="user" mr={1} />
                {record.name}
              </Box>
              <br />
              Rank: {record.rank}
              <br />
              Species: {record.species}
              <br />
              Gender: {record.gender}
              <br />
              {/* SKYRAT EDIT CHANGE - Chronological age, ORIGINAL: Age: {record.age} */}
              Physical Age: {record.age}
              {/* SKYRAT EDIT CHANGE END */}
              <br />
              {/* SKYRAT EDIT ADDITION BEGIN - Chronological age */}
              Chronological Age: {record.chrono_age}
              <br />
              {/* SKYRAT EDIT ADDITION END */}
              Fingerprint Hash: {record.fingerprint}
              <br />
              <br />
              Criminal Status: {record.wanted || 'DELETED'}
            </Section>
          ))}
        {mode === 'medical' &&
          records.map((record) => (
            <Section
              key={record.id}
              hidden={
                !(
                  searchTerm === '' ||
                  isMatchingSearchTerms(
                    record.name +
                      ' ' +
                      record.bloodtype +
                      ' ' +
                      record.mental_status +
                      ' ' +
                      record.physical_status,
                  )
                )
              }
            >
              <Box bold>
                <Icon name="user" mr={1} />
                {record.name}
              </Box>
              <br />
              {/* SKYRAT EDIT ADDITION BEGIN - Chronological age */}
              Physical Age: {record.age}
              <br />
              Chronological Age: {record.chrono_age}
              <br />
              {/* SKYRAT EDIT ADDITION END */}
              Bloodtype: {record.bloodtype}
              <br />
              Minor Disabilities: {record.mi_dis}
              <br />
              Major Disabilities: {record.ma_dis}
              <br />
              <br />
              Notes: {record.notes}
              <br />
              Notes Contd: {record.cnotes}
            </Section>
          ))}
      </NtosWindow.Content>
    </NtosWindow>
  );
};
