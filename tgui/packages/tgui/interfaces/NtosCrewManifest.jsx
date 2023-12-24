import { map } from 'common/collections';

import { useBackend } from '../backend';
import { Button, Section, Table } from '../components';
import { NtosWindow } from '../layouts';

// SKYRAT EDIT BEGIN - ALTERNATIVE_JOB_TITLES
//
// width={500} - Original: width={400}
//
// {entry.rank === entry.trim ? entry.rank : <>{entry.rank} ({entry.trim})</>}
//  - Original: entry.rank
export const NtosCrewManifest = (props) => {
  const { act, data } = useBackend();
  const { manifest = {} } = data;
  return (
    <NtosWindow width={500} height={480}>
      <NtosWindow.Content scrollable>
        <Section
          title="Crew Manifest"
          buttons={
            <Button
              icon="print"
              content="Print"
              onClick={() => act('PRG_print')}
            />
          }
        >
          {map((entries, department) => (
            <Section key={department} level={2} title={department}>
              <Table>
                {entries.map((entry) => (
                  <Table.Row key={entry.name} className="candystripe">
                    <Table.Cell bold>{entry.name}</Table.Cell>
                    <Table.Cell>
                      {entry.rank === entry.trim ? (
                        entry.rank
                      ) : (
                        <>
                          {entry.rank} ({entry.trim})
                        </>
                      )}
                    </Table.Cell>
                  </Table.Row>
                ))}
              </Table>
            </Section>
          ))(manifest)}
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};
// SKYRAT EDIT END - ALTERNATIVE_JOB_TITLES
