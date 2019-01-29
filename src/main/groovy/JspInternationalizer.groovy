import org.apache.commons.io.FilenameUtils
import org.jsoup.Jsoup
import org.jsoup.nodes.Document
import org.jsoup.nodes.Node
import org.jsoup.nodes.TextNode
import org.jsoup.parser.ParseSettings
import org.jsoup.parser.Parser
import org.jsoup.select.NodeVisitor

class JspInternationalizer {
    private static final String FILE_EXTENSION_PATTERN = '\\.(jsp|tag)$'
    private static final String[] TRANSLATABLE_ATTRIBUTES = ['label', 'title', 'alt', 'placeholder']
    private static final String OUTPUT_FILENAME = 'out.properties'

    static void main(String... args) {

        def translations = processPath('src/test/resources')

        new File(OUTPUT_FILENAME).setText(createTranslationMap(translations))
    }

    static Map processPath(final String path) {
        println "Processing directory ${path}..."
        def translations = [:]

        new File(path).eachFileRecurse({ file ->
            if (file.name =~ FILE_EXTENSION_PATTERN && FilenameUtils.getBaseName(file.name).count('.') == 0) {
                println "Processing file ${file.path}..."
                translations << processFile(file)
            }
        })

        return translations
    }

    static Map processFile(final File file) {
        def translations = [:]
        def prefix = file.name.replaceFirst(/\..*$/, '')
        def document = Jsoup.parse(file.newDataInputStream(), 'utf-8', '', Parser.xmlParser().settings(ParseSettings.preserveCase))
        def nodesToDelete = []
        document.traverse(new NodeVisitor() {
            @Override
            void head(Node node, int depth) {
                if (node instanceof TextNode && !node.toString().blank
                        && !node.toString().trim().startsWith('&lt;')
                        && !node.toString().trim().endsWith('&gt;')
                        && !node.toString().trim().startsWith('${')
                        && !node.toString().trim().startsWith('{{')
                        && node.hasParent() && 'script' != node.parent().nodeName()) {
                    def text = node.text().trim()
                    def key = createKey(prefix, text, translations as Map)
                    injectMessageTag(node as TextNode, key)
                    nodesToDelete << node
                    translations[key] = text
                } else {
                    TRANSLATABLE_ATTRIBUTES.each { attr ->
                        if (node.hasAttr(attr)) {
                            def text = node.attr(attr).trim()
                            def key = createKey(prefix, text, translations as Map)
                            replaceAttribute(node, attr, key)
                            translations[key] = text
                        }
                    }
                }
            }

            @Override
            void tail(Node node, int depth) {}
        })

        nodesToDelete.each { (it as Node).remove()}

        if (!translations.isEmpty()) {
            writeBackDocument(file, document)
        }

        return translations
    }

    static def injectMessageTag(TextNode node, String key) {
        node.before(createMessageTag(key))
    }

    static def replaceAttribute(Node node, String attribute, String key) {
        if (node.nodeName().contains(':')) {
            node.before(createMessageTag(key, 'translation'))
            node.attr(attribute, '${translation}')
        } else {
            node.attr(attribute, createMessageTag(key))
        }
    }

    static String createKey(final String prefix, final String text, Map translations) {
        def baseKey = prefix + '.' + text.toLowerCase()
                .replaceAll('ä', 'ae')
                .replaceAll('ö', 'oe')
                .replaceAll('ü', 'ue')
                .replaceAll('ß', 'ss')
                .replaceAll(/[^a-z0-9\s-]/, '')
                .replaceAll(/\s/, '.')

        return deduplicateKey(translations, baseKey)
    }

    static String deduplicateKey(final Map translations, String baseKey) {
        def key = baseKey
        def index = 0

        while (translations.get(key)) {
            key = baseKey + (++index)
        }

        return key
    }

    static String createMessageTag(final String key, final String var = null) {
        return "<spring:message code='${key}'${var ? " var='${var}'" : ''}/>"
    }

    static File writeBackDocument(final File inFile, final Document document) {
        final def newFileName = FilenameUtils.removeExtension(inFile.absolutePath) + '.translated.' + FilenameUtils.getExtension(inFile.name)
        final outFile = new File(newFileName)
        outFile.setText(document.toString())

        return outFile
    }

    static String createTranslationMap(Map translations) {
        translations = translations.sort { a, b -> a.key <=> b.key }

        def sb = new StringBuilder()
        translations.each {entry -> sb.append "${entry.key}=${entry.value}\n"}
        return sb.toString()
    }
}
