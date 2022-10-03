import { useBackend } from '../backend';
import { Collapsible, Section } from '../components';
import { NtosWindow } from '../layouts';

export const NtosNewsArchive = (props, context) => {
  const { data } = useBackend(context);
  const { stories } = data;

  return (
    <NtosWindow width={600} height={800}>
      <NtosWindow.Content scrollable>
        <Section textAlign="center">
          Archives from the Nanotrasen News Network!
        </Section>
        {stories.map((story) => (
          <Collapsible
            bold
            key={story.title}
            title={
              story.title +
              ' | Published ' +
              story.month +
              '/' +
              story.day +
              '/' +
              story.year
            }>
            <Section>{story.text}</Section>
          </Collapsible>
        ))}
      </NtosWindow.Content>
    </NtosWindow>
  );
};
