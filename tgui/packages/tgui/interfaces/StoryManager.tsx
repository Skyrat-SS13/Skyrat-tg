// THIS IS A SKYRAT UI FILE
import { useBackend, useLocalState } from '../backend';
import {
  Button,
  Collapsible,
  LabeledList,
  Section,
  TextArea,
} from '../components';
import { Window } from '../layouts';

type StoryManagerData = {
  current_stories: Story[];
  archived_stories: Story[];
  current_date: string;
};

type Story = {
  title: string;
  text: string;
  id: string;
  year: string;
  month: string;
  day: string;
};

export const StoryManager = (props) => {
  const { data, act } = useBackend<StoryManagerData>();
  const { current_stories, archived_stories, current_date } = data;

  const [title, setTitle] = useLocalState('title', '');
  const [text, setText] = useLocalState('text', '');
  const [id, setID] = useLocalState('id', '');

  return (
    <Window width={600} height={800} title="Lorecaster Manager">
      <Window.Content scrollable>
        <Section textAlign="center">
          Lorecaster story manager
          <br />
          <i>Anything published here will not appear until the next round!</i>
          <br />
          <span style={{ color: 'red' }}>
            Do not mess with this unless you know what you&apos;re doing.
          </span>
        </Section>
        <Section>
          <LabeledList>
            <LabeledList.Item label="Title">
              <TextArea
                height="20px"
                placeholder="A short, consise title/author for the article."
                onInput={(_e, value) => setTitle(value)}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Body Text">
              <TextArea
                height="100px"
                placeholder="The contents of the article itself."
                onInput={(_e, value) => setText(value)}
              />
            </LabeledList.Item>
            <LabeledList.Item label="ID">
              <TextArea
                height="20px"
                placeholder="A unique id for the article. Article will not publish if set ID is in use."
                onInput={(_e, value) => setID(value)}
              />
            </LabeledList.Item>
            <LabeledList.Item label="Date">
              <i>Publishing Date: {current_date}</i>
            </LabeledList.Item>
          </LabeledList>
          <Button
            icon="arrow-up"
            mr="9px"
            color="blue"
            onClick={() => {
              act('publish_article', {
                title: title,
                text: text,
                id: id,
              });
            }}
          >
            Publish
          </Button>
        </Section>
        <Collapsible title="Current Stories">
          {current_stories.map((story) => (
            <Collapsible
              bold
              key={story.id}
              title={
                story.title +
                ' | Published ' +
                story.month +
                '/' +
                story.day +
                '/' +
                story.year
              }
            >
              <Section>
                {story.text}
                <br />
                <Button
                  icon="book"
                  mr="9px"
                  color="red"
                  onClick={() => {
                    act('archive_article', {
                      id: story.id,
                    });
                  }}
                >
                  Archive
                </Button>
              </Section>
            </Collapsible>
          ))}
        </Collapsible>
        <Collapsible title="Archived Stories">
          {archived_stories.map((story) => (
            <Collapsible
              bold
              key={story.id}
              title={
                story.title +
                ' | Published ' +
                story.month +
                '/' +
                story.day +
                '/' +
                story.year
              }
            >
              <Section>
                {story.text}
                <br />
                <Button
                  icon="floppy-disk"
                  mr="9px"
                  color="green"
                  onClick={() => {
                    act('circulate_article', {
                      id: story.id,
                    });
                  }}
                >
                  Circulate
                </Button>
              </Section>
            </Collapsible>
          ))}
        </Collapsible>
      </Window.Content>
    </Window>
  );
};
