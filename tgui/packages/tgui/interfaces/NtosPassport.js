import { useBackend, useSharedState } from '../backend';
import { Box, Button, Input, NoticeBox, Section, Stack, NumberInput, Tabs } from '../components';
import { NtosWindow } from '../layouts';
import { PassportList } from './common/PassportList';

export const NtosPassport = (props, context) => {
  return (
    <NtosWindow width={500} height={670}>
      <NtosWindow.Content scrollable>
        <NtosPassportContent />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

export const NtosPassportContent = (props, context) => {
  const { act, data } = useBackend(context);
  const { authenticatedUser, has_passport, has_passport_slot } = data;

  if (!has_passport_slot) {
    return (
      <NoticeBox>
        This program requires a passport slot in order to function
      </NoticeBox>
    );
  }

  const [selectedTab] = useSharedState(context, 'selectedTab', 'login');

  return (
    <>
      <Stack>
        <Stack.Item>
          <IDCardPassportTabs />
        </Stack.Item>
        <Stack.Item width="100%">
          {(selectedTab === 'login' && <PassportLogin />) ||
            (selectedTab === 'modify' && <PassportTarget />)}
        </Stack.Item>
      </Stack>
      <Stack mt={1}>
        <Stack.Item grow>
          {!!has_passport && !!authenticatedUser && (
            <Box>
              <PassportList
                extraButtons={
                  <Button.Confirm
                    content="Clear Passport"
                    confirmContent="Wipe Passport?"
                    color="bad"
                    onClick={() => act('PRG_clearpassport')}
                  />
                }
                passportMod={(name) =>
                  act('PRG_changebackground', {
                    target: name,
                  })
                }
                backgrounds={data['backgrounds']}
                selectedEntries={data['selected']}
              />
            </Box>
          )}
        </Stack.Item>
      </Stack>
    </>
  );
};

const IDCardPassportTabs = (props, context) => {
  const [selectedTab, setSelectedTab] = useSharedState(
    context,
    'selectedTab',
    'login'
  );

  return (
    <Tabs vertical fill>
      <Tabs.Tab
        minWidth={'100%'}
        altSelection
        selected={'login' === selectedTab}
        color={'login' === selectedTab ? 'green' : 'default'}
        onClick={() => setSelectedTab('login')}>
        Login ID
      </Tabs.Tab>
      <Tabs.Tab
        minWidth={'100%'}
        altSelection
        selected={'modify' === selectedTab}
        color={'modify' === selectedTab ? 'green' : 'default'}
        onClick={() => setSelectedTab('modify')}>
        Target Passport
      </Tabs.Tab>
    </Tabs>
  );
};

export const PassportLogin = (props, context) => {
  const { act, data } = useBackend(context);
  const { authenticatedUser, authIDName } = data;

  return (
    <Section
      title="Login"
      buttons={
        <Button
          icon={authenticatedUser ? 'sign-out-alt' : 'sign-in-alt'}
          content={authenticatedUser ? 'Log Out' : 'Log In'}
          color={authenticatedUser ? 'bad' : 'good'}
          onClick={() => {
            act(authenticatedUser ? 'PRG_logout' : 'PRG_authenticate');
          }}
        />
      }>
      <Stack wrap="wrap">
        <Stack.Item width="100%">
          <Button
            fluid
            ellipsis
            icon="eject"
            content={authIDName}
            onClick={() => act('PRG_ejectauthid')}
          />
        </Stack.Item>
        <Stack.Item width="100%" mt={1} ml={0}>
          Login: {authenticatedUser || '-----'}
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const PassportTarget = (props, context) => {
  const { act, data } = useBackend(context);
  const { authenticatedUser, has_passport, name, age } = data;

  return (
    <Section title="Modify Passport">
      <Button
        width="100%"
        ellipsis
        icon="eject"
        content={name}
        onClick={() => act('PRG_ejectpassport')}
      />
      {!!(has_passport && authenticatedUser) && (
        <Stack mt={1}>
          <Stack.Item align="center">Details:</Stack.Item>
          <Stack.Item grow={1} mr={1} ml={1}>
            <Input
              width="100%"
              value={name}
              onInput={(e, value) =>
                act('PRG_name', {
                  name: value,
                })
              }
            />
          </Stack.Item>
          <Stack.Item>
            <NumberInput
              value={age || 0}
              unit="Years"
              minValue={17}
              maxValue={85}
              onChange={(e, value) => {
                act('PRG_age', {
                  age: value,
                });
              }}
            />
          </Stack.Item>
        </Stack>
      )}
    </Section>
  );
};
