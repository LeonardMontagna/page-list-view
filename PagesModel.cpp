#include "PagesModel.hpp"

#include <QDebug>
PagesModel::PagesModel(QObject *parent) : QAbstractListModel(parent)
{
    connect(this, &PagesModel::currentPageChanged, this,
            &PagesModel::createModelForPage);
}

int PagesModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_itemsModel->rowCount();
    //    const auto v       = m_itemsModel->rowCount() / 9;
    //    const auto perfect = (m_itemsModel->rowCount() % 9) == 0;
    //    return perfect ? v : v + 1;
}

QVariant PagesModel::data(const QModelIndex &index, int role) const
{
    Q_UNUSED(index)
    Q_UNUSED(role)
    return {};
}

int PagesModel::currentPage() const noexcept
{
    return m_currentPage;
}

void PagesModel::setCurrentPage(int value)
{
    m_currentPage = value;
    emit currentPageChanged();
}

QSortFilterProxyModel *PagesModel::itemsForPage()
{
    return &m_itemsForPage;
}

void PagesModel::setTotalItems(int number)
{
    m_number     = number;
    m_itemsModel = std::make_unique<ItemsModel>(m_number);
    emit currentPageChanged();
}

void PagesModel::createModelForPage()
{
    m_itemsForPage.setSourceModel(m_itemsModel.get());
    //    m_itemsForPage.setPage(m_currentPage);
    emit itemsForPageChanged();
}
