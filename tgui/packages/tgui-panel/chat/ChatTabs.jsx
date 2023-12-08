/**
 * @file
 * @copyright 2020 Aleksej Komarov
 * @license MIT
 */

import { useDispatch, useSelector } from 'common/redux';
import { Box, Tabs, Flex, Button } from 'tgui/components';
import { changeChatPage, addChatPage } from './actions';
import { selectChatPages, selectCurrentChatPage } from './selectors';
import { openChatSettings } from '../settings/actions';

const UnreadCountWidget = ({ value }) => (
  <Box
    style={{
<<<<<<< HEAD
      'font-size': '0.7em',
      'border-radius': '0.25em',
      'width': '1.7em',
      'line-height': '1.55em',
      'background-color': 'crimson',
      'color': '#fff',
    }}>
=======
      fontSize: '0.7em',
      borderRadius: '0.25em',
      width: '1.7em',
      lineHeight: '1.55em',
      backgroundColor: 'crimson',
      color: '#fff',
    }}
  >
>>>>>>> 2631b0b8ef1 (Replaces prettierx with the normal prettier (#80189))
    {Math.min(value, 99)}
  </Box>
);

export const ChatTabs = (props, context) => {
  const pages = useSelector(context, selectChatPages);
  const currentPage = useSelector(context, selectCurrentChatPage);
  const dispatch = useDispatch(context);
  return (
    <Flex align="center">
      <Flex.Item>
        <Tabs textAlign="center">
          {pages.map((page) => (
            <Tabs.Tab
              key={page.id}
              selected={page === currentPage}
              rightSlot={
                page.unreadCount > 0 && (
                  <UnreadCountWidget value={page.unreadCount} />
                )
              }
              onClick={() =>
                dispatch(
                  changeChatPage({
                    pageId: page.id,
                  }),
                )
              }
            >
              {page.name}
            </Tabs.Tab>
          ))}
        </Tabs>
      </Flex.Item>
      <Flex.Item ml={1}>
        <Button
          color="transparent"
          icon="plus"
          onClick={() => {
            dispatch(addChatPage());
            dispatch(openChatSettings());
          }}
        />
      </Flex.Item>
    </Flex>
  );
};
