import { useBackend } from '../backend';
import { Section } from '../components';
import { Window } from '../layouts';
export const IntensityCredits = (props, context) => {
  const { act, data } = useBackend(context);
  return (
    <Window title="ICES Events Panel" width={480} height={320} theme="admin">
      <Window.Content>
        <Section title="Configuration">
          You thought there would be something useful here? Ha! What a loser. :3
        </Section>
      </Window.Content>
    </Window>
  );
};
