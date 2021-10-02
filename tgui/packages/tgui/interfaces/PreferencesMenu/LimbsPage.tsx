import { Stack, Section, Dropdown, Button, ColorBox } from "../../components";
import { useBackend } from "../../backend";
import { PreferencesMenuData } from "./data";
import { CharacterPreview } from "./CharacterPreview";

export const Markings = (props, context) => {
  const { act } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack vertical>
      <Stack.Item>
        Markings:
      </Stack.Item>
      {props.limb.markings.markings_list.map((marking, index) => (
        <Stack.Item key={marking.marking_id}>
          <Stack>
            <Stack.Item grow>
              <Dropdown
                width="100%"
                options={props.limb.markings.marking_choices}
                displayText={marking.name}
                onSelected={(shit) => act("change_marking", { limb_slot: props.limb.slot, marking_id: marking.marking_id, marking_name: shit })}
              />
            </Stack.Item>
            <Stack.Item>
              <Button fill
                onClick={() => act("color_marking", { limb_slot: props.limb.slot, marking_id: marking.marking_id })}
              >
                <ColorBox color={marking.color}
                />
              </Button>
            </Stack.Item>
            <Stack.Item>
              <Button fill
                color="bad"
                onClick={() => act("remove_marking", { limb_slot: props.limb.slot, marking_id: marking.marking_id })}
              >
                -
              </Button>
            </Stack.Item>
          </Stack>
        </Stack.Item>
      ))}
      <Stack.Item>
        <Button fill
          color="good"
          onClick={() => act("add_marking", { limb_slot: props.limb.slot })}
        >
          +
        </Button>
      </Stack.Item>
    </Stack>
  );
};

export const LimbPage = (props, context) => {
  const { act } = useBackend<PreferencesMenuData>(context);
  return (
    <Section title={props.limb.name}>
      <Stack fill vertical>
        <Stack.Item>
          <Markings
            limb={props.limb}
          />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

export const AugmentationPage = (props, context) => {
  const { act } = useBackend<PreferencesMenuData>(context);
  if (props.limb.can_augment) {
    return (
      <Section title={props.limb.name}>
        <Stack fill vertical>
          <Stack.Item>
            <Stack vertical>
              <Stack.Item>
                <Stack fill>
                  <Stack.Item>
                    Augumentation:
                  </Stack.Item>
                  <Stack.Item grow>
                    <Dropdown grow
                      width="100%"
                      options={Object.values(props.limb.aug_choices)}
                      displayText={props.limb.chosen_aug}
                      onSelected={(value) => act("set_limb_aug", { limb_slot: props.limb.slot, augment_name: value })}
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item>
                <Stack fill vertical>
                  <Stack.Item>
                    Style:
                  </Stack.Item>
                  <Stack.Item grow>
                    <Dropdown grow
                      width="100%"
                      options={props.data.robotic_styles}
                      displayText={props.limb.chosen_style}
                      onSelected={(value) => act("set_limb_aug_style", { limb_slot: props.limb.slot, style_name: value })}
                    />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Section>
    );
  }
  return null;
};

export const OrganPage = (props, context) => {
  const { act } = useBackend<PreferencesMenuData>(context);
  return (
    <Stack.Item>
      <Stack fill>
        <Stack.Item>
          {props.organ.name + ": "}
        </Stack.Item>
        <Stack.Item grow>
          <Dropdown
            width="100%"
            options={Object.values(props.organ.organ_choices)}
            displayText={props.organ.chosen_organ}
            onSelected={(value) => act("set_organ_aug", { organ_slot: props.organ.slot, augment_name: value })}
          />
        </Stack.Item>
      </Stack>
    </Stack.Item>
  );
};

export const LimbsPage = (props, context) => {
  const { data } = useBackend<PreferencesMenuData>(context);
  const { act } = useBackend<PreferencesMenuData>(context);
  const markings = data.marking_presets ? data.marking_presets : [];
  return (
    <Stack fill>
      <Stack.Item minWidth="33%">
        <Section title="Markings">
          <Stack.Item>
            <Dropdown grow
              width="100%"
              options={Object.values(markings)}
              displayText="Pick a preset:"
              onSelected={(value) => act("set_preset", { preset: value })}
            />
          </Stack.Item>
          <Stack.Item>
            {data.limbs_data.map(val => (
              <LimbPage
                key={val.slot}
                limb={val}
                data={data}
              />
            ))}
          </Stack.Item>
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section fill title="Character Preview">
          <CharacterPreview
            id={data.character_preview_view}
            height="25%"
            width="100%"
          />
        </Section>
      </Stack.Item>
      <Stack.Item minWidth="33%">
        <Section title="Organs">
          <Stack fill vertical>
            {data.organs_data.map(val => (
              <OrganPage
                key={val.slot}
                organ={val}
                data={data}
              />
            ))}
          </Stack>
        </Section>
        <Section title="Augmentations">
          {data.limbs_data.map(val => (
            <AugmentationPage
              key={val.slot}
              limb={val}
              data={data}
            />
          ))}
        </Section>
      </Stack.Item>
    </Stack>
  );
};
