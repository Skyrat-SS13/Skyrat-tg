import { useBackend } from '../backend';
import { Box, Button, Section, Stack } from '../components';
import { Window } from '../layouts';

let palette;

export const MilkingMachine = (props, context) => {
  const { data } = useBackend(context);
  const { machine_color } = data;

  colorChange(machine_color);

  return (
    <Window resizable width={570} height={375}>
      <Window.Content
        fontSize="14px"
        backgroundColor={palette.WindowBackgroundColor}>
        <MilkingMachineContent />
      </Window.Content>
    </Window>
  );
};

const MilkingMachineContent = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    mobName,
    mobCanLactate,
    beaker,
    BeakerName,
    beakerMaxVolume,
    beakerCurrentVolume,
    mode,
    milkTankMaxVolume,
    milkTankCurrentVolume,
    girlcumTankMaxVolume,
    girlcumTankCurrentVolume,
    semenTankMaxVolume,
    semenTankCurrentVolume,
    current_vessel,
    current_selected_organ,
    current_selected_organ_name,
    current_breasts,
    current_testicles,
    current_vagina,
    machine_color,
  } = data;

  return (
    <Stack vertical textColor={palette.TextColor}>
      <Stack.Item>
        <Stack>
          <Stack.Item grow textAlign="center">
            {!data.mobName && (
              <Section backgroundColor={palette.SectionBackgroundColor}>
                No creature in machine loaded
              </Section>
            )}
            {data.mobName && (
              <Section backgroundColor={palette.SectionBackgroundColor}>
                Name: {mobName}
              </Section>
            )}
          </Stack.Item>
          <Stack.Item align="center">
            {mobName && (
              <Button
                icon="eject"
                content="Eject creature"
                textAlign="center"
                backgroundColor={palette.ButtonBackGroundColor}
                onClick={() => act('ejectCreature')}
              />
            )}
            {!mobName && (
              <Button
                icon="eject"
                content="Eject creature"
                textAlign="center"
                backgroundColor={palette.ButtonBackGroundColor}
                disabled
              />
            )}
          </Stack.Item>
        </Stack>
      </Stack.Item>
      <Stack.Item>
        <Stack>
          <Stack.Item grow>
            <Stack vertical>
              <Stack.Item grow={1}>
                <Section
                  bold
                  backgroundColor={palette.SectionBackgroundColor}
                  textAlign="center">
                  Machine control
                </Section>
              </Stack.Item>
              <Stack.Item>
                <Stack>
                  <Stack.Item grow={1}>
                    <Stack vertical>
                      <Stack.Item>
                        {modeButtonStates('Off', data, palette, context)}
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                  <Stack.Item grow={2}>
                    <Stack vertical>
                      <Stack.Item>
                        <Section
                          backgroundColor={palette.SectionBackgroundColor}
                          textAlign="center">
                          State: {mode}
                        </Section>
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                </Stack>
                <Stack>
                  <Stack.Item grow>
                    {modeButtonStates('Low', data, palette, context)}
                  </Stack.Item>
                  <Stack.Item grow>
                    {modeButtonStates('Medium', data, palette, context)}
                  </Stack.Item>
                  <Stack.Item grow>
                    {modeButtonStates('Hard', data, palette, context)}
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item grow={1}>
                <Section
                  bold
                  backgroundColor={palette.SectionBackgroundColor}
                  textAlign="center">
                  Organ control
                </Section>
              </Stack.Item>
              <Stack.Item>
                <Stack>
                  <Stack.Item grow={2}>
                    <Stack vertical>
                      <Stack>
                        <Stack.Item grow>
                          {current_selected_organ !== null && (
                            <Box as="div" m={1}>
                              <Button
                                content="Unplug"
                                textAlign="center"
                                width="100%"
                                backgroundColor={palette.ControlButtonOff}
                                textColor={palette.ControlButtonOffText}
                                bold
                                onClick={() => act('unplug')}
                              />
                            </Box>
                          )}
                          {current_selected_organ === null && (
                            <Box as="div" m={1}>
                              <Button
                                content="Unplug"
                                textAlign="center"
                                width="100%"
                                backgroundColor={palette.ControlButtonOn}
                                textColor={palette.ControlButtonOnText}
                                bold
                              />
                            </Box>
                          )}
                        </Stack.Item>
                        <Stack.Item grow>
                          {current_selected_organ === null && (
                            <Section
                              backgroundColor={palette.SectionBackgroundColor}
                              textAlign="center">
                              Organ: none
                            </Section>
                          )}
                          {current_selected_organ !== null && (
                            <Section
                              backgroundColor={palette.SectionBackgroundColor}
                              textAlign="center">
                              Organ: {current_selected_organ}
                            </Section>
                          )}
                        </Stack.Item>
                      </Stack>
                      <Stack>
                        <Stack.Item grow>
                          {current_selected_organ !== 'the breasts' &&
                            current_breasts !== null && (
                              <Box as="div" m={1}>
                                <Button
                                  content="Breasts"
                                  textAlign="center"
                                  width="100%"
                                  backgroundColor={palette.ControlButtonOff}
                                  textColor={palette.ControlButtonOffText}
                                  bold
                                  onClick={() => act('setBreasts')}
                                />
                              </Box>
                            )}
                          {current_selected_organ === 'the breasts' && (
                            <Box as="div" m={1}>
                              <Button
                                content="Breasts"
                                textAlign="center"
                                width="100%"
                                backgroundColor={palette.ControlButtonOn}
                                textColor={palette.ControlButtonOnText}
                                bold
                              />
                            </Box>
                          )}
                          {current_vagina === null && (
                            <Box as="div" m={1}>
                              <Button
                                content="Breasts"
                                textAlign="center"
                                width="100%"
                                backgroundColor={palette.ControlButtonOn}
                                textColor={palette.ControlButtonOnText}
                                bold
                                disabled
                              />
                            </Box>
                          )}
                        </Stack.Item>
                        <Stack.Item grow>
                          {current_selected_organ !== 'the vagina' &&
                            current_vagina !== null && (
                              <Box as="div" m={1}>
                                <Button
                                  content="Vagina"
                                  textAlign="center"
                                  width="100%"
                                  backgroundColor={palette.ControlButtonOff}
                                  textColor={palette.ControlButtonOffText}
                                  bold
                                  onClick={() => act('setVagina')}
                                />
                              </Box>
                            )}
                          {current_selected_organ === 'the vagina' && (
                            <Box as="div" m={1}>
                              <Button
                                content="Vagina"
                                textAlign="center"
                                width="100%"
                                backgroundColor={palette.ControlButtonOn}
                                textColor={palette.ControlButtonOnText}
                                bold
                              />
                            </Box>
                          )}
                          {current_vagina === null && (
                            <Box as="div" m={1}>
                              <Button
                                content="Vagina"
                                textAlign="center"
                                width="100%"
                                backgroundColor={palette.ControlButtonOn}
                                textColor={palette.ControlButtonOnText}
                                bold
                                disabled
                              />
                            </Box>
                          )}
                        </Stack.Item>
                        <Stack.Item grow>
                          {current_selected_organ !== 'the testicles' &&
                            current_testicles !== null && (
                              <Box as="div" m={1}>
                                <Button
                                  content="Testicles"
                                  textAlign="center"
                                  width="100%"
                                  backgroundColor={palette.ControlButtonOff}
                                  textColor={palette.ControlButtonOffText}
                                  bold
                                  onClick={() => act('setTesticles')}
                                />
                              </Box>
                            )}
                          {current_selected_organ === 'the testicles' && (
                            <Box as="div" m={1}>
                              <Button
                                content="Testicles"
                                textAlign="center"
                                width="100%"
                                backgroundColor={palette.ControlButtonOn}
                                textColor={palette.ControlButtonOnText}
                                bold
                              />
                            </Box>
                          )}
                          {current_testicles === null && (
                            <Box as="div" m={1}>
                              <Button
                                content="Testicles"
                                textAlign="center"
                                width="100%"
                                backgroundColor={palette.ControlButtonOn}
                                textColor={palette.ControlButtonOnText}
                                bold
                                disabled
                              />
                            </Box>
                          )}
                        </Stack.Item>
                      </Stack>
                    </Stack>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
          <Stack.Item grow>
            <Stack vertical>
              <Stack.Item grow>
                {beaker !== null && (
                  <Section
                    bold
                    backgroundColor={palette.SectionBackgroundColor}
                    textAlign="center">
                    Beaker: {BeakerName}
                  </Section>
                )}
                {beaker === null && (
                  <Section
                    bold
                    backgroundColor={palette.SectionBackgroundColor}
                    textAlign="center">
                    Beaker: none
                  </Section>
                )}
              </Stack.Item>
              <Stack.Item>
                <Stack>
                  <Stack.Item grow>
                    {beaker !== null && (
                      <Section
                        backgroundColor={palette.SectionBackgroundColor}
                        textAlign="center">
                        Volume: {Math.round(beakerCurrentVolume)} /{' '}
                        {Math.round(beakerMaxVolume)}
                      </Section>
                    )}
                    {beaker === null && (
                      <Section
                        backgroundColor={palette.SectionBackgroundColor}
                        textAlign="center">
                        Volume: n/a
                      </Section>
                    )}
                  </Stack.Item>
                  <Stack.Item align="center">
                    {beaker !== null && (
                      <Button
                        icon="eject"
                        content="Eject Beaker"
                        textAlign="center"
                        backgroundColor={palette.ButtonBackGroundColor}
                        onClick={() => act('ejectBeaker')}
                      />
                    )}
                    {beaker === null && (
                      <Button
                        icon="eject"
                        content="Eject Beaker"
                        textAlign="center"
                        backgroundColor={palette.ButtonBackGroundColor}
                        disabled
                      />
                    )}
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item>
                <Section
                  bold
                  backgroundColor={palette.SectionBackgroundColor}
                  textAlign="center">
                  Tanks status
                </Section>
              </Stack.Item>
              <Stack.Item>
                <Stack vertical>
                  <Stack.Item>
                    <Stack>
                      <Stack.Item grow basis="1rem">
                        {current_vessel === 'MilkContainer' && (
                          <Box as="div" m={1}>
                            <Button
                              content="Milk"
                              textAlign="center"
                              width="100%"
                              backgroundColor={palette.ControlButtonOn}
                              textColor={palette.ControlButtonOnText}
                              bold
                            />
                          </Box>
                        )}
                        {current_vessel !== 'MilkContainer' && (
                          <Box as="div" m={1}>
                            <Button
                              content="Milk"
                              textAlign="center"
                              width="100%"
                              backgroundColor={palette.ControlButtonOff}
                              textColor={palette.ControlButtonOffText}
                              bold
                              onClick={() => act('setMilk')}
                            />
                          </Box>
                        )}
                      </Stack.Item>
                      <Stack.Item grow basis="1rem">
                        <Section
                          backgroundColor={palette.SectionBackgroundColor}
                          textAlign="center">
                          {Math.round(milkTankCurrentVolume)} /{' '}
                          {Math.round(milkTankMaxVolume)}
                        </Section>
                      </Stack.Item>
                      <Stack.Item align="center">
                        <Button
                          content="50"
                          minWidth="30pt"
                          textAlign="center"
                          backgroundColor={palette.ButtonBackGroundColor}
                          onClick={() => act('transfer', { amount: 50 })}
                        />
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                  <Stack.Item>
                    <Stack>
                      <Stack.Item grow basis="1rem">
                        {current_vessel === 'GirlcumContainer' && (
                          <Box as="div" m={1}>
                            <Button
                              content="Girlcum"
                              textAlign="center"
                              width="100%"
                              backgroundColor={palette.ControlButtonOn}
                              textColor={palette.ControlButtonOnText}
                              bold
                            />
                          </Box>
                        )}
                        {current_vessel !== 'GirlcumContainer' && (
                          <Box as="div" m={1}>
                            <Button
                              content="Girlcum"
                              textAlign="center"
                              width="100%"
                              backgroundColor={palette.ControlButtonOff}
                              textColor={palette.ControlButtonOffText}
                              bold
                              onClick={() => act('setGirlcum')}
                            />
                          </Box>
                        )}
                      </Stack.Item>
                      <Stack.Item grow basis="1rem">
                        <Section
                          backgroundColor={palette.SectionBackgroundColor}
                          textAlign="center">
                          {Math.round(girlcumTankCurrentVolume)} /{' '}
                          {Math.round(girlcumTankMaxVolume)}
                        </Section>
                      </Stack.Item>
                      <Stack.Item align="center">
                        <Button
                          content="100"
                          minWidth="30pt"
                          textAlign="center"
                          backgroundColor={palette.ButtonBackGroundColor}
                          onClick={() => act('transfer', { amount: 100 })}
                        />
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                  <Stack.Item>
                    <Stack>
                      <Stack.Item grow basis="1rem">
                        {current_vessel === 'SemenContainer' && (
                          <Box as="div" m={1}>
                            <Button
                              content="Semen"
                              textAlign="center"
                              width="100%"
                              backgroundColor={palette.ControlButtonOn}
                              textColor={palette.ControlButtonOnText}
                              bold
                            />
                          </Box>
                        )}
                        {current_vessel !== 'SemenContainer' && (
                          <Box as="div" m={1}>
                            <Button
                              content="Semen"
                              textAlign="center"
                              width="100%"
                              backgroundColor={palette.ControlButtonOff}
                              textColor={palette.ControlButtonOffText}
                              bold
                              onClick={() => act('setSemen')}
                            />
                          </Box>
                        )}
                      </Stack.Item>
                      <Stack.Item grow basis="1rem">
                        <Section
                          backgroundColor={palette.SectionBackgroundColor}
                          textAlign="center">
                          {Math.round(semenTankCurrentVolume)} /{' '}
                          {Math.round(semenTankMaxVolume)}
                        </Section>
                      </Stack.Item>
                      <Stack.Item align="center">
                        <Button
                          content="All"
                          minWidth="30pt"
                          textAlign="center"
                          backgroundColor={palette.ButtonBackGroundColor}
                          onClick={() => act('transfer', { amount: 1000 })}
                        />
                      </Stack.Item>
                    </Stack>
                  </Stack.Item>
                </Stack>
              </Stack.Item>
            </Stack>
          </Stack.Item>
        </Stack>
      </Stack.Item>
    </Stack>
  );
};

const modeButtonStates = (Name, data, palette, context) => {
  const { act } = useBackend(context);
  let ModeNameCapital = capitalize(data.mode);
  let action = 'set' + Name + 'Mode';

  if (
    data.mobName !== null &&
    ModeNameCapital !== Name &&
    data.current_selected_organ !== null
  ) {
    return (
      <Box as="div" m={1}>
        <Button
          content={Name}
          textAlign="center"
          width="100%"
          backgroundColor={palette.ControlButtonOff}
          textColor={palette.ControlButtonOffText}
          bold
          onClick={() => act(action)}
        />
      </Box>
    );
  } else if (
    data.mobName !== null &&
    ModeNameCapital === Name &&
    data.current_selected_organ !== null
  ) {
    return (
      <Box as="div" m={1}>
        <Button
          content={Name}
          textAlign="center"
          width="100%"
          backgroundColor={palette.ControlButtonOn}
          textColor={palette.ControlButtonOnText}
          bold
        />
      </Box>
    );
  } else if (
    ModeNameCapital !== Name &&
    (data.current_selected_organ === null) === true
  ) {
    return (
      <Box as="div" m={1}>
        <Button
          content={Name}
          textAlign="center"
          width="100%"
          backgroundColor={palette.ControlButtonOn}
          textColor={palette.ControlButtonOnText}
          bold
          disabled
        />
      </Box>
    );
  } else if (ModeNameCapital === Name && data.current_selected_organ === null) {
    return (
      <Box as="div" m={1}>
        <Button
          content={Name}
          textAlign="center"
          width="100%"
          backgroundColor={palette.ControlButtonOn}
          textColor={palette.ControlButtonOnText}
          bold
        />
      </Box>
    );
  }
};

const organButtonStates = (Name, data, palette, context) => {
  const { act } = useBackend(context);
  let OrganNameCapital;
  if (data.current_selected_organ_name !== null) {
    OrganNameCapital = capitalize(data.current_selected_organ_name);
  } else {
    OrganNameCapital = '';
  }
  let action = 'set' + Name;

  if (
    OrganNameCapital !== Name &&
    data.current_breasts !== null &&
    data.mobCanLactate === true
  ) {
    return (
      <Box as="div" m={1}>
        <Button
          content={Name}
          textAlign="center"
          width="100%"
          backgroundColor={palette.ControlButtonOff}
          textColor={palette.ControlButtonOffText}
          bold
          onClick={() => act(action)}
        />
      </Box>
    );
  } else if (OrganNameCapital === Name) {
    return (
      <Box as="div" m={1}>
        <Button
          content={Name}
          textAlign="center"
          width="100%"
          backgroundColor={palette.ControlButtonOn}
          textColor={palette.ControlButtonOnText}
          bold
        />
      </Box>
    );
  } else if (
    data.current_selected_organ_name === null ||
    (OrganNameCapital !== Name && data.mobCanLactate === false)
  ) {
    return (
      <Box as="div" m={1}>
        <Button
          content={Name}
          textAlign="center"
          width="100%"
          backgroundColor={palette.ControlButtonOn}
          textColor={palette.ControlButtonOnText}
          bold
          disabled
        />
      </Box>
    );
  }
};

const capitalize = (g) => {
  if (typeof g !== 'string') return '';
  return g.charAt(0).toUpperCase() + g.slice(1);
};

const colorChange = (g) => {
  if (g === 'pink') {
    palette = {
      WindowBackgroundColor: '#403840',
      SectionBackgroundColor: '#1f071f',
      ButtonBackGroundColor: '#6067C4',
      TextColor: '#f5e8fa',
      ControlButtonOffText: '#00b050',
      ControlButtonOff: '#003020',
      ControlButtonOnText: '#ffffff',
      ControlButtonOn: '#00b050',
    };
    return;
  } else if (g === 'teal') {
    palette = {
      WindowBackgroundColor: '#002b34',
      SectionBackgroundColor: '#000b14',
      ButtonBackGroundColor: '#6067C4',
      TextColor: '#cef7ff',
      ControlButtonOffText: '#0096b3',
      ControlButtonOff: '#00404d',
      ControlButtonOnText: '#e2faff',
      ControlButtonOn: '#00abcd',
    };
    return;
  }
};
