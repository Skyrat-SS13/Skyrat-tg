import { toFixed } from 'common/math';
import { useBackend } from '../backend';
import { NoticeBox, Section, Stack, Button, LabeledList, ProgressBar } from '../components';
import { Window } from '../layouts';

export const MicrofusionGunControl = (props, context) => {
  const { act, data } = useBackend(context);
  const { cell_data } = data;
  const { phase_emitter_data } = data;
  const { loaded_projectile_data } = data;
  const {
    gun_name,
    has_cell,
    has_emitter,
    has_attachments,
    attachments = [],
  } = data;
  return (
    <Window
      title={'Micron Contol Systems Incorporated: ' + gun_name}
      width={700}
      height={600}>
      <Window.Content>
        <Stack vertical>
          <Stack.Item>
            <Section
              title="Power Cell"
              buttons={(
                <Button
                  icon="eject"
                  content="Eject Cell"
                  disabled={!has_cell}
                  onClick={() => act('eject_cell')} />
              )}>
              {has_cell ? (
                <LabeledList>
                  <LabeledList.Item label="Cell Type">
                    {cell_data.type}
                  </LabeledList.Item>
                  <LabeledList.Item label="Cell Status">
                    {cell_data.status ? 'ERROR' : 'Nominal'}
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
                </LabeledList>
              ) : (
                <NoticeBox color="bad">
                  No cell installed!
                </NoticeBox>
              )}
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section
              title="Phase Emitter"
              buttons={(
                <Button
                  icon="eject"
                  content="Eject Emitter"
                  disabled={!has_emitter}
                  onClick={() => act('eject_emitter')} />
              )}>
              {has_emitter ? (
                phase_emitter_data.damaged ? (
                  <NoticeBox color="bad">
                    Phase emitter is damaged!
                  </NoticeBox>
                ) : (
                  <LabeledList>
                    <LabeledList.Item label="Emitter Type">
                      {phase_emitter_data.type}
                    </LabeledList.Item>
                    <LabeledList.Item label="Temperature">
                      <ProgressBar
                        value={phase_emitter_data.current_heat}
                        minValue={0}
                        maxValue={phase_emitter_data.max_heat}
                        ranges={{
                          "bad": [phase_emitter_data.max_heat * 0.85, phase_emitter_data.max_heat * 2],
                          "average": [phase_emitter_data.max_heat * 0.25, phase_emitter_data.max_heat * 0.85],
                          "good": [0, phase_emitter_data.max_heat * 0.25],
                        }}>
                        {toFixed(phase_emitter_data.current_heat) + ' C' + ' (' + phase_emitter_data.heat_percent + '%)'}
                      </ProgressBar>
                    </LabeledList.Item>
                    <LabeledList.Item label="Maximum Temperature">
                      {phase_emitter_data.max_heat + ' C'}
                    </LabeledList.Item>
                    <LabeledList.Item label="Temperature Throttle Percent">
                      {phase_emitter_data.throttle_percentage + '% '}
                      <Button
                        icon="wrench"
                        content="Overclock"
                        color="bad"
                        disabled={!phase_emitter_data.hacked}
                        onClick={() => act('overclock_emitter')} />
                    </LabeledList.Item>
                    <LabeledList.Item label="Passive Heat Dissipation">
                      {phase_emitter_data.heat_dissipation_per_tick + ' C/s'}
                    </LabeledList.Item>
                    <LabeledList.Item label="Integrity">
                      <ProgressBar
                        value={phase_emitter_data.integrity}
                        minValue={0}
                        maxValue={100}
                        ranges={{
                          "good": [85, 100],
                          "average": [25, 85],
                          "bad": [0, 25],
                        }}>
                        {phase_emitter_data.integrity + '%'}
                      </ProgressBar>
                    </LabeledList.Item>
                    {phase_emitter_data.heat_percent
                    >= phase_emitter_data.throttle_percentage && (
                      <NoticeBox color="orange">
                        Thermal throttle active!
                      </NoticeBox>
                    )}
                    {phase_emitter_data.current_heat
                    >= phase_emitter_data.max_heat && (
                      <NoticeBox color="bad">
                        Overheating!
                      </NoticeBox>
                    )}
                  </LabeledList>
                )
              ) : (
                <NoticeBox color="bad">
                  No phase emitter installed!
                </NoticeBox>
              )}
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title="Beam Data">
              <LabeledList>
                <LabeledList.Item label="Damage">
                  {loaded_projectile_data.damage}
                </LabeledList.Item>
                <LabeledList.Item label="Damange Type">
                  {loaded_projectile_data.damage_type}
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Section title={"Attachments"}>
              {has_attachments ? (
                <LabeledList>
                  {attachments.map(attachment => (
                    <LabeledList.Item
                      label={attachment.name}
                      key={attachment.ref}
                      buttons={(
                        <Button
                          icon="eject"
                          content="Eject Attachment"
                          onClick={() => act('remove_attachment', {
                            attachment_ref: attachment.ref,
                          })} />
                      )}>
                      {attachment.desc}
                    </LabeledList.Item>
                  ))}
                </LabeledList>
              ) : (
                <NoticeBox color="blue">
                  No attachments installed!
                </NoticeBox>
              )}
            </Section>
          </Stack.Item>
        </Stack>
      </Window.Content>
    </Window>
  );
};
