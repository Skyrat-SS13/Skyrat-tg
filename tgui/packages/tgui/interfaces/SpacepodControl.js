import { useBackend, useSharedState } from '../backend';
import { NoticeBox, Section, Stack, Button, LabeledList, ProgressBar, Tabs } from '../components';
import { Window } from '../layouts';


export const SpacepodControl = (props, context) => {
  const [tab, setTab] = useSharedState(context, 'tab', 1);
  const { act, data } = useBackend(context);
  const {
    pod_name,
  } = data;
  return (
    <Window
      title={'Pod Control: ' + pod_name}
      width={500}
      height={700}>
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab
            selected={tab === 1}
            onClick={() => setTab(1)}>
            Pod Summary
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 2}
            onClick={() => setTab(2)}>
            Pod Equipment
          </Tabs.Tab>
          <Tabs.Tab
            selected={tab === 3}
            onClick={() => setTab(3)}>
            Cargo Hold
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && (
          <SummaryTab />
        )}
        {tab === 2 && (
          <EquipmentTab />
        )}
        {tab === 3 && (
          <CargoTab />
        )}
      </Window.Content>
    </Window>
  );
};

export const SummaryTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { cell_data } = data;
  const {
    pod_name,
    pod_pilot,
    has_occupants,
    occupants,
    locked,
    lights,
    brakes,
    has_cell,
    weapon_lock,
    velocity,
    integrity,
    max_integrity,

  } = data;
  return (
    <Stack vertical grow>
      <Stack.Item>
        <Section title="Helm">
          <LabeledList>
            <LabeledList.Item label="Velocity">
              <ProgressBar value={velocity} maxValue={10}>
                {velocity} M/s
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Integrity">
              <ProgressBar
                value={integrity}
                maxValue={max_integrity}
                ranges={{
                  "good": [integrity * 0.85, max_integrity],
                  "average": [integrity * 0.25, max_integrity * 0.85],
                  "bad": [0, max_integrity * 0.25],
                }}>
                {integrity / max_integrity * 100}%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Brake status">
              <Button
                icon={"stop-circle"}
                content={brakes ? 'Engaged' : 'Disengaged'}
                color={brakes ? 'good' : 'bad'}
                onClick={() => act('toggle_brakes')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title={'Spacepod Control'}
          buttons={(
            <Button
              icon="sign-out-alt"
              content="Exit Pod"
              onClick={() => act('exit_pod')} />
          )}>
          <LabeledList>
            <LabeledList.Item label="Name">
              {pod_name}
            </LabeledList.Item>
            <LabeledList.Item label="Lock status">
              <Button
                icon={locked ? 'unlock' : 'lock'}
                content={locked ? 'Locked' : 'Unlocked'}
                color={locked ? 'good' : 'bad'}
                onClick={() => act('toggle_locked')} />
            </LabeledList.Item>
            <LabeledList.Item label="Lights status">
              <Button
                icon={"lightbulb"}
                content={lights ? 'Online' : 'Offline'}
                color={lights ? 'good' : 'bad'}
                onClick={() => act('toggle_lights')} />
            </LabeledList.Item>
            <LabeledList.Item label="Weapons Lock">
              <Button
                icon={"fighter-jet"}
                content={weapon_lock ? 'Safe' : 'Ready to fire'}
                color={weapon_lock ? 'good' : 'bad'}
                onClick={() => act('toggle_weapon_lock')} />
            </LabeledList.Item>
          </LabeledList>
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Power Cell">
          {has_cell ? (
            <LabeledList>
              <LabeledList.Item label="Cell Type">
                {cell_data.type}
              </LabeledList.Item>
              <LabeledList.Item label="Cell Charge">
                <ProgressBar
                  value={cell_data.charge}
                  minValue={0}
                  maxValue={cell_data.max_charge}
                  ranges={{
                    "good": [cell_data.max_charge * 0.85, cell_data.max_charge],
                    "average": [cell_data.max_charge * 0.25, cell_data.max_charge * 0.85],
                    "bad": [0, cell_data.max_charge * 0.25],
                  }}>
                  {cell_data.charge + '/' + cell_data.max_charge + 'MF'}
                </ProgressBar>
              </LabeledList.Item>
              <LabeledList.Item>
                Cell can only be removed externally.
              </LabeledList.Item>
              {!!cell_data.charge <= 0 && (
                <LabeledList.Item>
                  <Section>
                    <NoticeBox color="bad">
                      Charge depleted!
                    </NoticeBox>
                  </Section>
                </LabeledList.Item>
              )}
            </LabeledList>
          ) : (
            <NoticeBox color="bad">
              No cell installed!
            </NoticeBox>
          )}
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Occupants">
          {has_occupants ? (
            occupants.map((occpuant, index) => (
              <LabeledList key={index}>
                <LabeledList.Item label="Name">
                  {occpuant.name}
                </LabeledList.Item>
              </LabeledList>
            ))
          ) : (
            <NoticeBox color="blue">
              No occupants detected!
            </NoticeBox>
          )}
        </Section>
      </Stack.Item>
    </Stack>
  );
};

export const EquipmentTab = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_equipment,
    equipment = [],
  } = data;
  return (
    <Section title={"Equipment"}>
      {has_equipment ? (
        equipment.map((equipment_thing, index) => (
          <Section
            key={index}
            title={equipment_thing.name}
            buttons={(
              <Button
                icon="eject"
                content="Eject Equipment"
                onClick={() => act('remove_equipment', {
                  equipment_ref: equipment_thing.ref,
                })} />
            )}>
            <LabeledList>
              <LabeledList.Item label="Description">
                {equipment_thing.desc}
              </LabeledList.Item>
              <LabeledList.Item label="Slot">
                {equipment_thing.slot}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        ))
      ) : (
        <NoticeBox color="blue">
          No equipment installed!
        </NoticeBox>
      )}
    </Section>
  );
};

export const CargoTab = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    has_bays,
    cargo_bays = [],
  } = data;
  return (
    <Section title={"Cargo Hold"}>
      {has_bays ? (
        cargo_bays.map((bay, index) => (
          <Section
            key={index}
            title={bay.name}
            buttons={(
              <Button
                icon="eject"
                disabled={bay.cargo === "none"}
                content="Eject Cargo"
                onClick={() => act('unload_cargo', {
                  cargo_bay_ref: bay.ref,
                })} />
            )}>
            <LabeledList>
              <LabeledList.Item label="Contents">
                {bay.storage}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        ))
      ) : (
        <NoticeBox color="blue">
          No cargo bay installed!
        </NoticeBox>
      )}
    </Section>
  );
};
