import { toTitleCase } from 'common/string';
import { useBackend } from '../backend';
import { Box, Button, LabeledList, Section, Table, NoticeBox } from '../components';
import { Window } from '../layouts';

export const Skyrat_SolGovGTFO = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    lift_status,
    list_of_riders,
  } = data;
  return (
    <Window
      width={315}
      height={440}>
      <NoticeBox danger>
        Authorized SolGov personnel only
      </NoticeBox>
      <Window.Content>
        <Section title="SolGov Fastpass™ Lift">
          <LabeledList>
            <LabeledList.Item label="Status">
              {lift_status}
            </LabeledList.Item>
            <LabeledList.Item
              buttons={(
                <Button
                  content="Activate Lift"
                  onClick={() => act('activate_lift')} />
              )} />
          </LabeledList>
        </Section>
        <Section title="Current riders">
          <Table>
            <Table.Row header>
              <Table.Cell>
                Rider
              </Table.Cell>
              <Table.Cell collapsing textAlign="right">
                Occupation
              </Table.Cell>
            </Table.Row>
            {list_of_riders.map(found_rider => (
              <Table.Row>
                <Table.Cell>
                  {toTitleCase(found_rider.get_authentification_name())}
                </Table.Cell>
                <Table.Cell collapsing textAlign="right">
                  <Box color="label" inline>
                    {found_rider.get_assignment()}
                  </Box>
                </Table.Cell>
              </Table.Row>
            ))}
          </Table>
        </Section>
      </Window.Content>
    </Window>
  );
};
