import { Button, Section, Stack } from '../components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

const toggleNames = {
  0: "it is zero",
  1: "See Examine Messages",
  2: "See Struggle Messages",
  3: "See Other Vore Messages",
  4: "Devourable",
  5: "Digestable",
  6: "Absorbable",
};

export const VorePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    enabled,
    toggles,
    unsaved,
    bellies,
  } = data;
  return (
    <Window
      title={"Vore Panel"}
      width={420}
      height={510}>
      <Window.Content scrollable>
        <Section>
          <Stack>
            <Stack.Item grow>
              <Button
                content={enabled ? "Enable Vore" : "Disable Vore"}
                color={enabled ? "green" : "red"}
                onClick={() => act('toggle_vore', {
                  toggle: !enabled,
                })} />
            </Stack.Item>
          </Stack>
        </Section>
        {enabled === true && (
          <Section title="Toggles">
            <Stack>
              {toggles.map((val, i) => (
                <Stack.Item key={i}>
                  <Button
                    content={toggleNames[i]}
                    color={val ? "green" : "red"}
                    onClick={() => act('toggle_act', {
                      pref: i,
                      toggle: !val,
                    })} />
                </Stack.Item>
              ))}
            </Stack>
          </Section>
        )}
      </Window.Content>
    </Window>
  );
};