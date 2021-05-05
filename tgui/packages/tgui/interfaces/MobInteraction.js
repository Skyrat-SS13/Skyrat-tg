import { map } from 'common/collections';
import { useBackend } from '../backend';
import { Button, Section, BlockQuote, Flex } from '../components';
import { Window } from '../layouts';

export const MobInteraction = (props, context) => {
  const { act, data } = useBackend(context);
  const {
    isTargetSelf,
    interactingWith,
    selfAttributes,
    theirAttributes,
  } = data;
  const interactions = data.interactions || [];
  return (
    <Window
      width={340}
      height={480}
      resizable>
      <Window.Content scrollable>
        <Section title={interactingWith}>
          <BlockQuote>
            You...<br />
            {selfAttributes.map(attribute => (
              <div key={attribute}>
                {attribute}<br />
              </div>
            ))}
          </BlockQuote>
          {!isTargetSelf ? (
            <BlockQuote>
              They...<br />
              {theirAttributes.map(attribute => (
                <div key={attribute}>
                  {attribute}<br />
                </div>
              ))}
            </BlockQuote>
          ) : (null)}
        </Section>
        {interactions.length ? (
          <Section>
            <Flex direction="column">
              {interactions.map(interaction => (
                <Button
                  key={interaction[1]}
                  content={interaction[1]}
                  color={interaction[2] === 2 ? "red" : interaction[2] ? "pink" : "default"}
                  onClick={() => act('interact', {
                    interaction: interaction[0],
                  })} />
              ))}
            </Flex>
          </Section>
        ) : (null)}
      </Window.Content>
    </Window>
  );
};
