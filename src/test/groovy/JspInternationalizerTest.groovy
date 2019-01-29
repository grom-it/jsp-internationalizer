import org.apache.commons.io.FileUtils
import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.jsoup.nodes.Element
import org.jsoup.nodes.Node
import org.jsoup.nodes.TextNode
import org.junit.Test

import static org.junit.Assert.assertEquals
import static org.junit.Assert.assertTrue

class JspInternationalizerTest {
    @Test
    void createKey() {
        assertEquals("prefix.was.ich.noch.zu.sagen.hatte",
                JspInternationalizer.createKey("prefix", "Was ich noch zu sagen hatte!", Collections.emptyMap()))
    }

    @Test
    void deduplicateKey() {
        assertEquals("key", JspInternationalizer.deduplicateKey(Collections.emptyMap(), "key"))
        assertEquals("key1", JspInternationalizer.deduplicateKey(Collections.singletonMap("key", "text"), "key"))
        assertEquals("key2", JspInternationalizer.deduplicateKey(new HashMap() {
            {
                put("key", "text")
                put("key1", "text")
            }
        }, "key"))
    }

    @Test
    void createMessageTag() {
        assertEquals("<spring:message code='key'/>", JspInternationalizer.createMessageTag("key"))
        assertEquals("<spring:message code='key' var='attr'/>", JspInternationalizer.createMessageTag("key", "attr"))
    }

    @Test
    void writeBackDocument() {
        final File inputFile = new File(FileUtils.getTempDirectory().absolutePath + '/test.jsp')
        final Document document = Jsoup.parseBodyFragment('<p/>')

        final outputFile = JspInternationalizer.writeBackDocument(inputFile, document)
        assertTrue(outputFile.exists())
        inputFile.delete()
        outputFile.delete()
    }

    @Test
    void createTranslationMap() {
        final HashMap map = new HashMap() {
            {
                put("zzz", "string")
                put("mmm", "blubb")
                put("aaa", "asdf")
            }
        }

        assertEquals("aaa=asdf\nmmm=blubb\nzzz=string\n", JspInternationalizer.createTranslationMap(map))
    }

    @Test
    void injectMessageTag() {
        final Document document = Jsoup.parseBodyFragment(
                '<p id="a"></p>ich bin der fließtext<p id="c"></p>')
        final TextNode nodeToReplace = (TextNode) document.getElementById("a").nextSibling()

        JspInternationalizer.injectMessageTag(nodeToReplace, "testkey")
        nodeToReplace.remove()

        final Element insertedNode = document.getElementsByTag("spring:message").first()
        assertEquals("a", insertedNode.previousElementSibling().id())
        assertEquals("c", insertedNode.nextElementSibling().id())
    }

    @Test
    void replaceAttributeInline() {
        Node node = new Element("a").attr("title", "Titel")

        JspInternationalizer.replaceAttribute(node, "title", "key")

        assertEquals("<spring:message code='key'/>", node.attr("title"))
    }

    @Test
    void replaceJstlAttribute() {
        final Document document = Jsoup.parseBodyFragment('<attributes:priceAttribute title="Titel"/>')
        final node = document.getElementsByTag('attributes:priceAttribute').first()

        JspInternationalizer.replaceAttribute(node, "title", "key")

        def injectedNode = node.previousElementSibling()
        assertEquals('spring:message', injectedNode.nodeName())
        assertEquals('key', injectedNode.attr('code'))
        assertEquals('${translation}', node.attr("title"))
    }
}
