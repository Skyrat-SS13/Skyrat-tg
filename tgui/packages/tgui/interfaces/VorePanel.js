import { Button, Section, Dropdown, Stack, Flex } from '../components';
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
    case 3:
      return "Unabsorb";
    default:
      return mode;
  }
};
const switchNames = {
  "name": "Name",
  "desc": "Description",
  "mode": "Mode",
  "can_taste": "Can Taste",
  "swallow_verb": "Swallow Verb",
  "tastes_of": "Tastes of",
};
const stringNames = {
  "dmp": "Digest (to prey)",
  "dmo": "Digest (to pred)",
  "amp": "Absorb (to prey)",
  "amo": "Absorb (to pred)",
  "ump": "Unabsorb (to prey)",
  "umo": "Unabsorb (to pred)",
  "smi": "Struggle (to inside)",
  "smo": "Struggle (to outside)",
  "em": "Examine",
};

const buttonFromName = (buttonName, index, action, textContent) => {
  return (
    <Flex.Item key={index}>
      <Flex direction="row" grow fill align="baseline">
        <Flex.Item>
          <Button
            minWidth={8}
            mb={1}
            content={buttonName}
            onClick={action}
          />
        </Flex.Item>
        <Flex.Item pr={3} pl={2} pb={1} pu={1}
          grow fill preserveWhitespace >
          {textContent}
        </Flex.Item>
      </Flex>
    </Flex.Item>
  );
};

export const BellyStack = (props, context) => {
  const { act, data } = useBackend(context);
  const { 
    current_belly,
    bellies,
    string_types,
    selected_belly,
    other_belly_types,
  } = data;
  return (
    <Section title="Bellies" buttons={(
      <Stack>
        <Stack.Item>
          <Button
            content="Remove Belly"
            color="red"
            height={1.61}
            disabled={bellies.length <= 1 ? true : false}
            onClick={() => act('remove_belly', { belly: selected_belly })} />
        </Stack.Item>
        <Stack.Item>
          <Dropdown
            options={bellies}
            height={1.61}
            selected={bellies[selected_belly - 1]}
            onSelected={(value) => act('select_belly', { belly: bellies.indexOf(value) + 1 })} />
        </Stack.Item>
      </Stack>
    )}>
      <Flex direction="column" fill>
        {other_belly_types.map((value, index) => {
          return buttonFromName(
            switchNames[value],
            index,
            () => act('belly_act', { varname: value, belly: selected_belly }),
            modeToText(current_belly[value]));
        })}
      </Flex>
      <Section title="Messages">
        <Flex wrap="wrap">
          Messages that will be sent upon:
        </Flex>
        <Flex wrap="wrap" pu={1.5}>
          {string_types.map((value, index) => (
            <Flex.Item key={index} pr={1} pb={0.5}>
              <Button
                content={stringNames[value]}
                onClick={() => act('belly_act', { varname: value, belly: selected_belly })} />
            </Flex.Item>
          ))}
        </Flex>
      </Section>
      <ContentsStack />
    </Section>
  );
};

export const ContentsStack = (props, context) => {
  const { act, data } = useBackend(context);
  const { has_contents, selected_belly } = data;
  if (has_contents) {
    const { contents } = data;
    return (
      <Section title="Contents" buttons={(
        <Button
          content="Eject All"
          color="red"
          onClick={() => act('eject_all', { belly: selected_belly })} />
      )}>
        <Flex wrap="wrap">
          {contents.map((value, index) => (
            <Flex.Item key={index} pr={1} pb={0.5}>
              <Button
                content={value["name"]}
                textColor={value["absorbed"] && "purple"}
                onClick={() => act('contents_act', { ref: value["ref"], belly: selected_belly })} />
            </Flex.Item>
          ))}
        </Flex>
      </Section>
    );
  }
  return null;
};

export const InsideStack = (props, context) => {
  const { act, data } = useBackend(context);
  const in_belly = data["in_belly"];
  if (in_belly) {
    const inside_data = data["inside_data"];
    return (
      <Section title={"Inside of " + inside_data["name"]}>
        <Flex direction="column">
          <Flex wrap="wrap">
            <Flex.Item align="center" preserveWhitespace
              textAlign="center" mb={1} wrap="wrap">
              {inside_data["desc"]}
            </Flex.Item>
          </Flex>
          <Flex wrap="wrap">
            {inside_data["contents"].map((value, index) => (
              <Flex.Item key={index} pr={1} pb={0.5} pu={1}>
                <Button
                  content={value["name"]}
                  textColor={value["absorbed"] && "purple"}
                  onClick={() => act('inside_act', {
                    ref: value["ref"],
                    belly_in: inside_data["belly_inside"],
                  })} />
              </Flex.Item>
            ))}
          </Flex>
        </Flex>
      </Section>
    );
  }
  return null;
};

export const VorePanel = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    enabled,
    toggles,
    unsaved,
    selected_belly,
    other_prefs,
    other_types,
  } = data;
  return (
    <Window
      title={"Vore Panel"}
      width={420}
      height={510}>
      <Window.Content scrollable>
        <Section
          title={unsaved ? "Save Prefs (Unsaved)" : "Save Prefs"}
          buttons={(
            <Stack>
              <Stack.Item>
                <Button
                  content={"Discard Changes"}
                  color="red"
                  disabled={!unsaved}
                  onClick={() => act('discard_changes', { belly: selected_belly })} />
              </Stack.Item>
              <Stack.Item>
                <Button
                  content={"Save Prefs"}
                  color="red"
                  onClick={() => act('save_prefs')} />
              </Stack.Item>
            </Stack>
          )} />
        <InsideStack />
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
          {!!enabled && (
            <BellyStack />
          )}
          {!!enabled && (
            <Section title="Toggles and other Prefs">
              <Flex wrap="wrap" >
                {toggles.map((val, i) => (
                  <Flex.Item key={i} pr={1} pb={0.5}>
                    <Button
                      content={toggleNames[i]}
                      color={val ? "green" : "red"}
                      onClick={() => act('toggle_act', {
                        pref: i+1,
                        toggle: !val,
                      })} />
                  </Flex.Item>
                ))}
              </Flex>
              <Section title="Other Prefs">
                <Flex direction="column" fill>
                  {other_types.map((value, index) => {
                    return buttonFromName(
                      switchNames[value],
                      index,
                      () => act('othervar_act', { varname: value }),
                      other_prefs[value]);
                  })}
                </Flex>
              </Section>
            </Section>
          )}
        </Section>
      </Window.Content>
    </Window>
  );
};