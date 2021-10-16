import { useBackend } from '../backend';
import { Stack, Section, ByondUi } from '../components';
import { Window } from '../layouts';

export const ExaminePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    character_name,
    obscured,
    assigned_map,
    flavor_text,
    ooc_notes,
    custom_species,
    custom_species_lore,
  } = data;
  return (
    <Window
      title="Examine Panel"
      width={900}
      height={670}
      theme="admin">
      <Window.Content>
        <Stack fill>
          <Stack.Item width="30%">
            <Section fill title="Character Preview">
              {!obscured
              && (
                <ByondUi
                  height="100%"
                  width="100%"
                  className="ExaminePanel__map"
                  params={{
                    id: assigned_map,
                    type: 'map',
                  }} />
              )}
            </Section>
          </Stack.Item>
          <Stack.Item grow>
            <Stack fill vertical>
              <Stack.Item grow>
                <Section scrollable fill title={character_name + "'s Flavor Text:"}>
                  {flavor_text.split("\n").map((val, i) => (
                    <Stack.Item key={i} grow fill>
                      {val || val !== "" ? val : <br />}
                    </Stack.Item>
                  ))}
                </Section>
              </Stack.Item>
              <Stack.Item grow>
                <Stack fill>
                  <Stack.Item grow basis={0}>
                    <Section scrollable fill title="OOC Notes">
                      {ooc_notes.split("\n").map((val, i) => (
                        <Stack.Item key={i} grow fill>
                          {val || val !== "" ? val : <br />}
                        </Stack.Item>
                      ))}
                    </Section>
                  </Stack.Item>
                  <Stack.Item grow basis={0}>
                    <Section scrollable fill title={(custom_species ? "Species: " + custom_species : "No Custom Species!")}>
                      {(custom_species ? custom_species_lore.split("\n").map((val, i) => (
                        <Stack.Item key={i} grow fill>
                          {val || val !== "" ? val : <br />}
                        </Stack.Item>
                      )) : "Just a normal space dweller.")}
                    </Section>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
