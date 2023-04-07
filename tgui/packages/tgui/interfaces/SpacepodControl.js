import { useBackend, useSharedState } from '../backend';
import { toFixed } from 'common/math';
import { NoticeBox, Section, Stack, Button, LabeledList, ProgressBar, Tabs } from '../components';
import { Window } from '../layouts';

export const SpacepodControl = (props, context) => {
  const [tab, setTab] = useSharedState(context, 'tab', 1);
  const { act, data } = useBackend(context);
  const { pod_name } = data;
  return (
    <Window title={'Pod Control: ' + pod_name} width={500} height={900}>
      <Window.Content scrollable>
        <Tabs>
          <Tabs.Tab selected={tab === 1} onClick={() => setTab(1)}>
            Pod Summary
          </Tabs.Tab>
          <Tabs.Tab selected={tab === 2} onClick={() => setTab(2)}>
            Weapons
          </Tabs.Tab>
          <Tabs.Tab selected={tab === 3} onClick={() => setTab(3)}>
            Pod Equipment
          </Tabs.Tab>
          <Tabs.Tab selected={tab === 4} onClick={() => setTab(4)}>
            Cargo Hold
          </Tabs.Tab>
        </Tabs>
        {tab === 1 && <SummaryTab />}
        {tab === 2 && <WeaponTab />}
        {tab === 3 && <EquipmentTab />}
        {tab === 4 && <CargoTab />}
      </Window.Content>
    </Window>
  );
};

export const SummaryTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { cell_data } = data;
  const {
    pod_pilot,
    has_occupants,
    occupants,
    locked,
    lights,
    alarm_muted,
    brakes,
    has_cell,
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
              <ProgressBar value={velocity} maxValue={21}>
                {velocity} M/s
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Integrity">
              <ProgressBar
                value={integrity}
                maxValue={max_integrity}
                ranges={{
                  'good': [integrity * 0.85, max_integrity],
                  'average': [integrity * 0.25, max_integrity * 0.85],
                  'bad': [0, max_integrity * 0.25],
                }}>
                {toFixed((integrity / max_integrity) * 100)}%
              </ProgressBar>
            </LabeledList.Item>
            <LabeledList.Item label="Vector Thrust Braking">
              <Button
                icon={'space-shuttle'}
                content={brakes ? 'Engaged' : 'Disengaged'}
                color={brakes ? 'good' : 'bad'}
                onClick={() => act('toggle_brakes')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Pilot Name">{pod_pilot}</LabeledList.Item>
          </LabeledList>
        </Section>
        <Section
          title={'Spacepod Control'}
          buttons={
            <Button
              icon="sign-out-alt"
              content="Exit Pod"
              onClick={() => act('exit_pod')}
            />
          }>
          <LabeledList>
            <LabeledList.Item label="Lock status">
              <Button
                icon={locked ? 'unlock' : 'lock'}
                content={locked ? 'Locked' : 'Unlocked'}
                color={locked ? 'good' : 'bad'}
                onClick={() => act('toggle_locked')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Lights status">
              <Button
                icon={'lightbulb'}
                content={lights ? 'Online' : 'Offline'}
                color={lights ? 'good' : 'bad'}
                onClick={() => act('toggle_lights')}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Alarm">
              <Button
                icon={alarm_muted ? 'volume-xmark' : 'volume-high'}
                content={alarm_muted ? 'Muted' : 'Enabled'}
                color={alarm_muted ? 'bad' : 'good'}
                onClick={() => act('mute_alarm')}
              />
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
                    'good': [cell_data.max_charge * 0.85, cell_data.max_charge],
                    'average': [
                      cell_data.max_charge * 0.25,
                      cell_data.max_charge * 0.85,
                    ],
                    'bad': [0, cell_data.max_charge * 0.25],
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
                    <NoticeBox color="bad">Charge depleted!</NoticeBox>
                  </Section>
                </LabeledList.Item>
              )}
            </LabeledList>
          ) : (
            <NoticeBox color="bad">No cell installed!</NoticeBox>
          )}
        </Section>
      </Stack.Item>
      <Stack.Item>
        <Section title="Occupants">
          {has_occupants ? (
            occupants.map((occpuant, index) => (
              <LabeledList key={index}>
                <LabeledList.Item label="Name">{occpuant}</LabeledList.Item>
              </LabeledList>
            ))
          ) : (
            <NoticeBox color="blue">No occupants detected!</NoticeBox>
          )}
        </Section>
      </Stack.Item>
    </Stack>
  );
};

export const WeaponTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { has_weapons, weapon_lock, weapons = [], selected_weapon_slot } = data;
  return (
    <Section
      title="Weapons Control"
      buttons={
        <Button
          icon={'fighter-jet'}
          content={weapon_lock ? 'Safe' : 'Ready to fire'}
          color={weapon_lock ? 'good' : 'bad'}
          onClick={() => act('toggle_weapon_lock')}
        />
      }>
      {has_weapons ? (
        weapons.map((weapon, index) => (
          <Section
            key={index}
            title={weapon.type}
            buttons={
              <Button
                icon={
                  selected_weapon_slot === weapon.slot
                    ? 'square-check'
                    : 'square'
                }
                content={
                  selected_weapon_slot === weapon.slot ? 'Selected' : 'Select'
                }
                disabled={selected_weapon_slot === weapon.slot}
                color={selected_weapon_slot === weapon.slot ? 'green' : 'blue'}
                onClick={() =>
                  act('switch_weapon_slot', {
                    selected_slot: weapon.slot,
                  })
                }
              />
            }>
            <LabeledList>
              <LabeledList.Item label="Description">
                {weapon.desc}
              </LabeledList.Item>
              <LabeledList.Item label="Slot">{weapon.slot}</LabeledList.Item>
            </LabeledList>
          </Section>
        ))
      ) : (
        <NoticeBox color="blue">No equipment installed!</NoticeBox>
      )}
    </Section>
  );
};

export const EquipmentTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { has_equipment, equipment = [] } = data;
  return (
    <Section title={'Equipment'}>
      {has_equipment ? (
        equipment.map((equipment_thing, index) => (
          <Section
            key={index}
            title={equipment_thing.name}
            buttons={
              <Button
                icon="eject"
                content="Eject Equipment"
                onClick={() =>
                  act('remove_equipment', {
                    equipment_ref: equipment_thing.ref,
                  })
                }
              />
            }>
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
        <NoticeBox color="blue">No equipment installed!</NoticeBox>
      )}
    </Section>
  );
};

export const CargoTab = (props, context) => {
  const { act, data } = useBackend(context);
  const { has_bays, cargo_bays = [] } = data;
  return (
    <Section title={'Cargo Hold'}>
      {has_bays ? (
        cargo_bays.map((bay, index) => (
          <Section
            key={index}
            title={bay.name}
            buttons={
              <Button
                icon="eject"
                disabled={bay.cargo === 'none'}
                content="Eject Cargo"
                onClick={() =>
                  act('unload_cargo', {
                    cargo_bay_ref: bay.ref,
                  })
                }
              />
            }>
            <LabeledList>
              <LabeledList.Item label="Contents">
                {bay.storage}
              </LabeledList.Item>
            </LabeledList>
          </Section>
        ))
      ) : (
        <NoticeBox color="blue">No cargo bay installed!</NoticeBox>
      )}
    </Section>
  );
};
