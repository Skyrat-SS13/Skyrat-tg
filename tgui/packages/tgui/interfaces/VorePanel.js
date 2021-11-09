import { Button, Section, Dropdown, Flex } from '../components';
import { useBackend } from '../backend';
import { Window } from '../layouts';

const toggleNames = {
  0: "See Examine Messages",
  1: "See Struggle Messages",
  2: "See Other Vore Messages",
  3: "Devourable",
  4: "Digestable",
  5: "Absorbable",
};
const modeToText = (mode) => {
  switch (mode) {
    case 0:
      return "Hold";
    case 1:
      return "Digest";
    case 2:
      return "Absorb";
    default:
      return mode;
  }
};
const switchNames = {
  "name": "Name",
  "desc": "Description",
  "mode": "Mode",
  "swallow_verb": "Swallow Verb",
};
const stringNames = {
  "digest_messages_prey": "Prey Digest Messages",
  "digest_messages_owner": "Pred Digest Messages",
  "struggle_messages_inside": "Struggle Messages Inside",
  "struggle_messages_outside": "Struggle Messages Outside",
  "examine_messages": "Examine Messages",
};

export const BellyStack = (props, context) => {
  const { act, data } = useBackend(context);
  const { 
    current_belly,
    bellies,
    string_types,
    selected_belly,
    other_types,
  } = data;
  const buttonFromName = (name, index) => {
    return (
      <Flex.Item key={index}>
        <Flex direction="row">
          <Flex.Item>
            <Button
              content={switchNames[name]}
              onClick={() => act('belly_act', { varname: name, belly: selected_belly })}
            />
          </Flex.Item>
          <Flex.Item align="end">
            {modeToText(current_belly[name])}
          </Flex.Item>
        </Flex>
      </Flex.Item>
    );
  };
  return (
    <Section title="Bellies" buttons={(
      <Dropdown
        options={bellies}
        selected={bellies[selected_belly - 1]}
        onSelected={(value) => act('select_belly', { belly: bellies.indexOf(value) + 1 })} />
    )}>
      <Flex direction="column">
        {other_types.map((value, index) => {
          return buttonFromName(value, index);
        })}
      </Flex>
      <Section title="Messages">
        <Flex wrap="wrap">
          {string_types.map((value, index) => (
            <Flex.Item key={index}>
              <Button
                content={stringNames[value]}
                onClick={() => act('belly_act', { varname: value, belly: selected_belly })} />
            </Flex.Item>
          ))}
        </Flex>
      </Section>
    </Section>
  );
};

export const VorePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { enabled, toggles, unsaved, selected_belly } = data;
  return (
    <Window
      title={"Vore Panel"}
      width={420}
      height={510}>
      <Window.Content scrollable>
        <Section
          title={unsaved ? "Save Prefs (Unsaved)" : "Save Prefs"}
          buttons={(
            <Flex>
              <Flex.Item>
                <Button
                  content={"Discard Changes"}
                  color="red"
                  disabled={!unsaved}
                  onClick={() => act('discard_changes', { belly: selected_belly })} />
              </Flex.Item>
              <Flex.Item>
                <Button
                  content={"Save Prefs"}
                  color="red"
                  onClick={() => act('save_prefs')} />
              </Flex.Item>
            </Flex>
          )} />
        <Section
          title="Vore Prefs"
          buttons={(
            <Button
              content={enabled ? "Disable Vore" : "Enable Vore"}
              color={enabled ? "green" : "red"}
              onClick={() => act('toggle_vore', {
                toggle: !enabled,
              })} />
          )} >
          {enabled && (
            <BellyStack />
          )}
          {enabled && (
            <Section title="Toggles">
              <Flex wrap="wrap">
                {toggles.map((val, i) => (
                  <Flex.Item key={i}>
                    <Button
                      content={toggleNames[i]}
                      color={val ? "green" : "red"}
                      onClick={() => act('toggle_act', {
                        pref: i,
                        toggle: !val,
                      })} />
                  </Flex.Item>
                ))}
              </Flex>
            </Section>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};