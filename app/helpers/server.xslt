<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="/">
        <table class="table table-hover">
            <tr>
              <th>Индекс</th>
              <th>Число</th>
            </tr>
            <xsl:for-each select="objects/object">
            <tr>
              <td>
                <xsl:value-of select="index"></xsl:value-of>
              </td>
              <td>
                <xsl:value-of select="number"></xsl:value-of>
              </td>
            </tr>
             </xsl:for-each>
            <tr>
              <th>Количество:</th>
              <th><xsl:value-of select="count(objects/object)"/></th>
            </tr>
        </table>
  </xsl:template>
</xsl:stylesheet>
