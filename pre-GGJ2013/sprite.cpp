#include <QPointF>

#include "sprite.hpp"

Sprite::Sprite(Game *game, QString file) :
    GameObject(game),
    m_pixmap(file),
    m_scale(QPointF(1.f, 1.f))
{
}

void Sprite::prePaint(QPainter *painter)
{
    Q_UNUSED(painter);
}

void Sprite::paint(QPainter *painter, const QStyleOptionGraphicsItem *option, QWidget *widget)
{
    prePaint(painter);
    painter->drawPixmap((-m_pixmap.width() / 2) * m_scale.x(),
                        (-m_pixmap.height() / 2) * m_scale.y(),
                        m_pixmap);
    Q_UNUSED(option);
    Q_UNUSED(widget);
}

QRectF Sprite::boundingRect() const
{
    return QRectF(-m_pixmap.width() / 2, -m_pixmap.height() / 2, m_pixmap.width(), m_pixmap.height());
}

QPointF Sprite::scale() const
{
    return m_scale;
}

void Sprite::setScale(QPointF scale)
{
    m_scale = scale;
    qDebug() << m_scale;
}
